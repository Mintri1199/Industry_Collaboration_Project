//
//  ImagePreviewViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    // MARK: Custom UIs
    private lazy var imageView = CompleteImageVIew(frame: .zero)
    private lazy var saveButton = BigBlueButton(frame: .zero)
    private lazy var previewButton = BigBlueButton(frame: .zero)
    let viewModel = ImagePreviewViewModel()
    weak var coordinator: MainCoordinator?
    
    private var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        let nameArray = viewModel.selectedGoals.compactMap { $0.name }
        image = viewModel.processImage(nameArray)
    }
}

// MARK: - UIs setup functions
extension ImagePreviewViewController {
    
    private func setupViews() {
        setupNavBar()
        setupBlueButton()
        setupImageView()
        setupPreviewButton()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20)
            ])
    }
    private func setupPreviewButton() {
        view.addSubview(previewButton)
        previewButton.setTitle("Live", for: .normal)
        previewButton.addTarget(self, action: #selector(presentPreview), for: .touchUpInside)
        NSLayoutConstraint.activate([
            previewButton.widthAnchor.constraint(equalToConstant: 75),
            previewButton.heightAnchor.constraint(equalToConstant: 50),
            previewButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            previewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupBlueButton() {
        view.addSubview(saveButton)
        saveButton.setTitle("Save Image", for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
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
    
    @objc private func presentPreview() {
        let previewVC = LivePreviewViewController()
        previewVC.livePreview.image = image
        present(previewVC, animated: true, completion: nil)
    }
    
    @objc private func saveTapped() {
        guard let image = imageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savingImageHandler(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func savingImageHandler(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
