//
//  CreateImageViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit
import CoreImage

class CreateImageViewController: UIViewController {
    
    // MARK: - Custom UIs
    private lazy var createImageButton = BigBlueButton(frame: .zero)
    private lazy var chooseImageLabel = BlueLabel(frame: .zero)
    private lazy var chooseGoalLabel = BlueLabel(frame: .zero)
    private lazy var imageSelectionCV = ImagesSelectionCV(frame: .zero, collectionViewLayout: ImageSelectionLayout())
    private lazy var goalsTableView = GoalsTableView(frame: .zero, style: .plain)
    private lazy var changeGoalsButton = GrayTextButton(frame: .zero)
    private lazy var emptyView = SelectedGoalsEmptyView()
    private let goalsVC = GoalsSelectionViewController()
    private let viewModel = SelectionViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
        setupChangeGoalsButtonButton()
        setupTableView()
    }
    
    private func setupImageCollectionView() {
        self.view.addSubview(imageSelectionCV)
        imageSelectionCV.delegate = self
        imageSelectionCV.dataSource = self
        NSLayoutConstraint.activate([
            imageSelectionCV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            imageSelectionCV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
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
        createImageButton.isHidden = true
        createImageButton.setTitle("Create", for: .normal)
        createImageButton.addTarget(self, action: #selector(pushToPreview), for: .touchUpInside)
        NSLayoutConstraint.activate([
            createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            createImageButton.heightAnchor.constraint(equalToConstant: 50),
            createImageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setupChangeGoalsButtonButton() {
        self.view.addSubview(changeGoalsButton)
        changeGoalsButton.isHidden = true
        changeGoalsButton.label.text = "Change goals"
        changeGoalsButton.label.textAlignment = .right
        changeGoalsButton.addTarget(self, action: #selector(changeGoalTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            changeGoalsButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            changeGoalsButton.heightAnchor.constraint(equalTo: chooseImageLabel.heightAnchor),
            changeGoalsButton.topAnchor.constraint(equalTo: chooseGoalLabel.topAnchor),
            changeGoalsButton.leadingAnchor.constraint(equalTo: chooseGoalLabel.trailingAnchor, constant: 50)
        ])
    }
    
    private func setupTableView() {
        self.view.addSubview(goalsTableView)
        goalsTableView.dataSource = self
        goalsTableView.allowsSelection = false
        goalsTableView.tableFooterView = UIView(frame: .zero)
        NSLayoutConstraint.activate([
            goalsTableView.topAnchor.constraint(equalTo: chooseGoalLabel.bottomAnchor, constant: 5),
            goalsTableView.leadingAnchor.constraint(equalTo: chooseImageLabel.leadingAnchor),
            goalsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            goalsTableView.bottomAnchor.constraint(equalTo: createImageButton.topAnchor, constant: -10)
        ])
    }
    
    private func setupCustomEmptyView() {
        emptyView.frame = goalsTableView.bounds
        goalsTableView.backgroundView = emptyView
        emptyView.chooseGoalButton.addTarget(self, action: #selector(pushToGoalSelection), for: .touchUpInside)
        goalsTableView.separatorStyle = .none
    }
    
    private func setupNavBar() {
        navigationItem.title = "Create Wallpaper"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Create Wallpaper")
    }
}

// MARK: - CAAnimationDelegate
extension CreateImageViewController: CAAnimationDelegate {
    // TODO: Figure out to implement animation in MVVM
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let button = anim.value(forKey: "button") as? BigBlueButton {
            if let value = anim.value(forKey: "name") as? String {
                button.isHidden = value == "moveDown"
            }
        }
    }
}

// MARK: - Objc functions
extension CreateImageViewController {
    @objc private func pushToPreview() {
        guard let image = viewModel.selectedImage else {
            return
        }
        let previewVC = ImagePreviewViewController()
        previewVC.viewModel.unprocessImage = image
        previewVC.viewModel.selectedGoals = viewModel.selectedGoals
        navigationController?.pushViewController(previewVC, animated: true)
    }
    
    @objc private func pushToGoalSelection() {
        goalsVC.delegate = self
        navigationController?.pushViewController(goalsVC, animated: true)
    }
    
    @objc private func changeGoalTapped() {
        goalsVC.viewModel.preselectGoals(viewModel.selectedGoals)
        navigationController?.pushViewController(goalsVC, animated: true)
    }
}

extension CreateImageViewController: PassSelectedGoals {
    func passSelectedGoals(_ array: [Goal]) {
        viewModel.selectedGoals = array.isEmpty ? [] : array
        changeGoalsButton.isHidden = array.isEmpty
        viewModel.validation(button: createImageButton)
        goalsTableView.reloadData()
    }
}

// MARK: - CollectionViewDatasource
extension CreateImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageSelectionCV.dequeueReusableCell(withReuseIdentifier: imageSelectionCV.cellID, for: indexPath) as? ImageSelectionCell else {
            return UICollectionViewCell()
        }
        // Commented until integrating Image API
//        indexPath.row == viewModel.imageArray.count ?   cell.setupShowMoreViews() :
//            cell.getImage(viewModel.imageArray[indexPath.row])
        cell.getImage(viewModel.imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - CollectionViewDelegate
extension CreateImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Commented until integrating Image API
//        if indexPath.row == viewModel.imageArray.count {
//            return
//        }
        
        imageSelectionCV.indexPathsForVisibleItems.forEach { (index) in
            if index != indexPath {
                if let otherCell = imageSelectionCV.cellForItem(at: index) as? ImageSelectionCell {
                    otherCell.borderLayer.lineWidth = 0
                }
            } else {
                if let selectedCell = imageSelectionCV.cellForItem(at: index) as? ImageSelectionCell {
                    selectedCell.borderLayer.lineWidth = 5
                    viewModel.selectedImage = selectedCell.cellImage
                }
            }
        }
        viewModel.validation(button: createImageButton)
    }
}

// MARK: - TableViewDelegate
extension CreateImageViewController: UITableViewDelegate {
    // Currently serving no purpose at the moment but later can use drag to order
}

// MARK: - TableViewDataSource
extension CreateImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.selectedGoals.isEmpty ? setupCustomEmptyView() : tableView.restore()
        return viewModel.selectedGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalsTableView.cellId, for: indexPath)
        if let name = viewModel.selectedGoals[indexPath.row].name {
            cell.textLabel?.text = name
        }
        return cell
    }
}
