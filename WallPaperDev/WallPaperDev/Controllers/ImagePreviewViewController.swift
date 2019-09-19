//
//  ImagePreviewViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    
    // Custom UIs
    lazy var imageView = CompleteImageVIew(frame: .zero)
    lazy var setAsWallpaperButton = BigBlueButton(frame: .zero)
    lazy var mockGoalLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Buy a house"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
}

// MARK: - UIs setup functions
extension ImagePreviewViewController {
    
    private func setupViews() {
        setupNavBar()
        setupBlueButton()
        setupImageView()
        setupLabel()
    }
    
    private func setupImageView() {
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: setAsWallpaperButton.topAnchor, constant: -20)
            ])
    }

    private func setupBlueButton() {
        self.view.addSubview(setAsWallpaperButton)
        setAsWallpaperButton.setTitle("Complete", for: .normal)
        NSLayoutConstraint.activate([
            setAsWallpaperButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            setAsWallpaperButton.heightAnchor.constraint(equalToConstant: 50),
            setAsWallpaperButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            setAsWallpaperButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Preview"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Preview")
    }
    
    private func setupLabel() {
        imageView.addSubview(mockGoalLabel)
        NSLayoutConstraint.activate([
            mockGoalLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            mockGoalLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            mockGoalLabel.heightAnchor.constraint(equalToConstant: 100),
            mockGoalLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
            ])
    }
}
