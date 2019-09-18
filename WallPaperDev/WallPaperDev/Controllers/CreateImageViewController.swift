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
    lazy var chooseGoalLabel = BlueLabel(frame: .zero)
    lazy var imageSelectionCV = ImagesSelectionCV(frame: .zero, collectionViewLayout: ImageSelectionLayout())
    lazy var goalsTableView = GoalsTableView(frame: .zero, style: .plain)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        goalsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
    }
}

// MARK: - Setup UI functions
extension CreateImageViewController {
    
    private func setupViews() {
        setupNavBar()
        setupBlueButton()
        setupChooseImageLabel()
        setupImageCollectionView()
        setupChooseGoalLabel()
        setupTableView()
    }
    
    private func setupImageCollectionView() {
        self.view.addSubview(imageSelectionCV)
        NSLayoutConstraint.activate([
            imageSelectionCV.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            imageSelectionCV.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            imageSelectionCV.topAnchor.constraint(equalToSystemSpacingBelow: chooseImageLabel.bottomAnchor, multiplier: 0.5)
            ])
    }
    
    private func setupChooseImageLabel() {
        chooseImageLabel.text = "Choose Image"
        self.view.addSubview(chooseImageLabel)
        NSLayoutConstraint.activate([
            chooseImageLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            chooseImageLabel.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            chooseImageLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            chooseImageLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
            ])
    }
    private func setupChooseGoalLabel() {
        chooseGoalLabel.text = "Choose Goal"
        self.view.addSubview(chooseGoalLabel)
        NSLayoutConstraint.activate([
            chooseGoalLabel.widthAnchor.constraint(equalTo: chooseImageLabel.widthAnchor),
            chooseGoalLabel.heightAnchor.constraint(equalTo: chooseImageLabel.heightAnchor),
            chooseGoalLabel.leadingAnchor.constraint(equalTo: chooseImageLabel.leadingAnchor),
            chooseGoalLabel.topAnchor.constraint(equalTo: imageSelectionCV.bottomAnchor)
            ])
    }
    
    private func setupBlueButton() {
        self.view.addSubview(createImageButton)
        createImageButton.setTitle("Create", for: .normal)
        createImageButton.addTarget(self, action: #selector(pushToPreview), for: .touchUpInside)
        NSLayoutConstraint.activate([
            createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            createImageButton.heightAnchor.constraint(equalToConstant: 50),
            createImageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    
    private func setupTableView() {
        self.view.addSubview(goalsTableView)
        NSLayoutConstraint.activate([
            goalsTableView.topAnchor.constraint(equalTo: chooseGoalLabel.bottomAnchor, constant: 5),
            goalsTableView.leadingAnchor.constraint(equalTo: chooseImageLabel.leadingAnchor),
            goalsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            goalsTableView.bottomAnchor.constraint(equalTo: createImageButton.topAnchor, constant: -10)
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
