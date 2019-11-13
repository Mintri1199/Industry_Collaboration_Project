//
//  SearchImageViewController.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {
    // MARK: - Custom UIs
    private lazy var createImageButton = BigBlueButton(frame: .zero)
    private lazy var chooseImageLabel = BlueLabel(frame: .zero)
    private lazy var chooseGoalLabel = BlueLabel(frame: .zero)
    private lazy var searchImagesCV = SearchImagesCV(frame: .zero, collectionViewLayout: SearchImagesCVLayout())
    private lazy var goalsTableView = GoalsTableView(frame: .zero, style: .plain)
    private lazy var changeGoalsButton = GrayTextButton(frame: .zero)
    private lazy var emptyView = SelectedGoalsEmptyView()
    private let goalsVC = GoalsSelectionViewController()
    private let viewModel = SearchImagesViewModel()
    private lazy var searchController = UISearchController(searchResultsController: nil)

    weak var coordinator: MainCoordinator?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupNavBar()
        setupChooseImageLabel()
        setupImageCollectionView()
        setupBlueButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupImageCollectionView() {
        self.view.addSubview(searchImagesCV)
        searchImagesCV.delegate = self
        searchImagesCV.dataSource = self
        NSLayoutConstraint.activate([
            searchImagesCV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchImagesCV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            // changed height anchor multiplier to 0.8, was 0.3
            searchImagesCV.topAnchor.constraint(equalToSystemSpacingBelow: chooseImageLabel.bottomAnchor, multiplier: 0.5),
            searchImagesCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    private func setupNavBar() {
        searchController.searchBar.delegate = self
//        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
        // add search to navigation bar
        searchController.searchBar.placeholder = "Search for images"
        searchController.searchBar.autocorrectionType = .default
        searchController.searchBar.sizeToFit()
//        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 20)
//        searchBar.placeholder = "Search for images"
//        searchBar.autocorrectionType = .default
//        searchBar.sizeToFit()
        
        navigationItem.title = "Search for a new image"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Search Images")
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
       
//        navigationController?.view.addSubview(searchBar)
//        NSLayoutConstraint.activate([searchBar.bottomAnchor.constraint])
//        navigationItem.titleView = searchController.searchBar
//        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupBlueButton() {
        self.view.addSubview(createImageButton)
//        self.view.bringSubviewToFront(createImageButton)
//        createImageButton.isHidden = true
        createImageButton.setTitle("Create", for: .normal)
        createImageButton.addTarget(self, action: #selector(backToChooseImageVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            createImageButton.heightAnchor.constraint(equalToConstant: 50),
            createImageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
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
    
    @objc private func backToChooseImageVC() {
        
    }
}

extension SearchImageViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchImagesCV.indexPathsForVisibleItems.forEach { (index) in
            if index != indexPath {
                if let otherCell = searchImagesCV.cellForItem(at: index) as? SearchImagesCell {
                    otherCell.borderLayer.lineWidth = 0
                }
            } else {
                if let selectedCell = searchImagesCV.cellForItem(at: index) as? SearchImagesCell {
                    selectedCell.borderLayer.lineWidth = 5
//                    viewModel.selectedImage = selectedCell.cellImage
                }
            }
        }
    }
    
}

extension SearchImageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchImagesCV.dequeueReusableCell(withReuseIdentifier: searchImagesCV.cellID, for: indexPath) as? SearchImagesCell else {
            return UICollectionViewCell()
        }
        cell.setupLabel()
        cell.getImage(viewModel.imageArray[indexPath.row])

        return cell
    }
}

extension SearchImageViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = searchBar.text
        let finalKeyword = keywords?.replacingOccurrences(of: " ", with: "+")
        print("Yellow lol \(keywords)")
    }
}
    
    

