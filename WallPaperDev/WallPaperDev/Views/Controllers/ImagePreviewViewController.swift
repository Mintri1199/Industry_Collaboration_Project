//
//  ImagePreviewViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CropViewController
import UIKit

class ImagePreviewViewController: UIViewController {
  // MARK: Custom UIs

  private lazy var imageView = CompleteImageVIew(frame: .zero)
  private lazy var saveButton = BigBlueButton(frame: .zero)
  private lazy var previewButton = BigBlueButton(frame: .zero)
  private lazy var recropButton = BigBlueButton(frame: .zero)
  private lazy var buttonStackView = UIStackView(frame: .zero)
  let viewModel = ImagePreviewViewModel()
  weak var coordinator: MainCoordinator?

  private var image: UIImage? {
    didSet {
      DispatchQueue.main.async {
        self.imageView.image = self.image
      }
    }
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setupViews()

    viewModel.initialGenerate { initialImage in
      self.image = initialImage
    }
  }
}

// MARK: - UIs setup functions

extension ImagePreviewViewController {
  private func setupViews() {
    setupNavBar()
    setupButtonStackView()
    setupImageView()
  }

  private func setupImageView() {
    view.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      imageView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20),
        ])
  }

  private func setupButtonStackView() {
    let blankButton = UIButton()
    blankButton.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.addArrangedSubview(recropButton)
    buttonStackView.addArrangedSubview(saveButton)
    buttonStackView.addArrangedSubview(previewButton)
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.axis = .horizontal

    buttonStackView.spacing = 20
    buttonStackView.distribution = .fillProportionally

    recropButton.setTitle("Crop", for: .normal)
    recropButton.addTarget(self, action: #selector(recropButtonTapped), for: .touchUpInside)

    saveButton.setTitle("Save Image", for: .normal)
    saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

    previewButton.setTitle("Edit", for: .normal)
    previewButton.addTarget(self, action: #selector(presentPreview), for: .touchUpInside)

    view.addSubview(buttonStackView)

    NSLayoutConstraint.activate([
      buttonStackView.heightAnchor.constraint(equalToConstant: 50),
      buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            blankButton.widthAnchor.constraint(equalTo: previewButton.widthAnchor, multiplier: 1)
      recropButton.widthAnchor.constraint(equalTo: previewButton.widthAnchor, multiplier: 1),
        ])

    // Comment the following lines when debugging
    recropButton.isEnabled = false //
    recropButton.backgroundColor = .clear //
    recropButton.titleLabel?.textColor = UIColor.clear //
  }

  private func setupNavBar() {
    navigationItem.title = "Preview"
    navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Preview")
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(popToHomeScreen))
  }
}

// MARK: - Objc functions

extension ImagePreviewViewController {
  @objc private func popToHomeScreen() {
    coordinator?.popToHome()
  }

  @objc private func recropButtonTapped() {
    guard let cropVC = viewModel.configureCropVC() else {
      return
    }
    cropVC.delegate = self
    present(cropVC, animated: true, completion: nil)
  }

  @objc private func presentPreview() {
    let vc = EditTextLabelViewController()

    if #available(iOS 13.0, *) {
      vc.modalPresentationStyle = .fullScreen
    }
    vc.livePreview.image = viewModel.croppedImage
    vc.viewModel.delegate = self
    vc.viewModel.labelText = viewModel.labelText
    vc.viewModel.labelRotation = viewModel.textLayerRotation ?? 0
    vc.viewModel.labelFrame = viewModel.textLayerRect
    present(vc, animated: true, completion: nil)
  }

  @objc private func saveTapped() {
    guard let image = imageView.image else {
      return
    }
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(savingImageHandler(_:didFinishSavingWithError:contextInfo:)), nil)
  }

  @objc func savingImageHandler(_: UIImage, didFinishSavingWithError error: Error?, contextInfo _: UnsafeRawPointer) {
    if let error = error {
      let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    } else {
      let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)

      let add = UIAlertAction(title: "OK", style: .default) { _ in
        self.coordinator?.popToHome()
      }
      ac.addAction(add)
      present(ac, animated: true)
    }
  }
}

// MARK: - Save text label changes

extension ImagePreviewViewController: SaveChange {
  func applyChanges(_ textFrame: CGRect, _ layerRotation: CGFloat) {
    viewModel.textLayerRect = textFrame
    viewModel.textLayerRotation = layerRotation
    viewModel.updateImage { result in
      switch result {
      case let .success(image):
        self.image = image
      case let .failure(error):
        #if DEBUG
          print(error)
        #endif
      }
    }
  }
}

// MARK: - CropViewController Delegate

extension ImagePreviewViewController: CropViewControllerDelegate {
  func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
    viewModel.croppedImage = image
    viewModel.currentCropRect = cropRect
    viewModel.rotate = angle
    viewModel.updateImage { result in
      switch result {
      case let .success(processedImage):
        self.image = processedImage
      case let .failure(error):
        #if DEBUG
          print(error)
        #endif
      }
    }
    cropViewController.dismiss(animated: true, completion: nil)
  }
}
