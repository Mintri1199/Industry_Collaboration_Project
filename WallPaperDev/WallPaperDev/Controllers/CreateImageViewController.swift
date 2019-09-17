//
//  CreateImageViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateImageViewController: UIViewController {
    // MARK: - Custom UIs
    lazy var createImageButton = BigBlueButton(frame: .zero)
    lazy var chooseImageLabel = BlueLabel(frame: .zero)
    lazy var imageSelectionCV = ImagesSelectionCV(frame: .zero, collectionViewLayout: ImageSelectionLayout())
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupNavBar()
        _setupBlueButton()
        _setupChooseImageLabel()
        _setupImageCollectionView()
    }
}

// MARK: - Setup UI functions
extension CreateImageViewController {
    
    private func _setupImageCollectionView() {
        self.view.addSubview(imageSelectionCV)
        NSLayoutConstraint.activate([
            imageSelectionCV.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            imageSelectionCV.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            imageSelectionCV.topAnchor.constraint(equalToSystemSpacingBelow: chooseImageLabel.bottomAnchor, multiplier: 0.5)
            ])
    }
    
    private func _setupChooseImageLabel() {
        chooseImageLabel.text = "Choose Image"
        self.view.addSubview(chooseImageLabel)
        NSLayoutConstraint.activate([
            chooseImageLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            chooseImageLabel.heightAnchor.constraint(equalToConstant: 50),
            chooseImageLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.view.safeAreaLayoutGuide.leftAnchor, multiplier: 2),
            chooseImageLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
            ])
    }
    
    private func _setupBlueButton() {
        self.view.addSubview(createImageButton)
        createImageButton.setTitle("Create", for: .normal)
        createImageButton.addTarget(self, action: #selector(pushToPreview), for: .touchUpInside)
        NSLayoutConstraint.activate([
            createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            createImageButton.heightAnchor.constraint(equalToConstant: 50),
            createImageButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100),
            createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }

    private func setupNavBar() {
        navigationItem.title = "Create Wallpaper"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: .long)
    }
}

// MARK: - Objc functions
extension CreateImageViewController {
    @objc func pushToPreview() {
        let previewVC = ImagePreviewViewController()
        navigationController?.pushViewController(previewVC, animated: true)
    }
}
