//
//  SearchImageViewController.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol SelectedImageDelegate {
  func passImageSelected(image: UIImage)
}

class SearchImageViewController: UIViewController {
  // MARK: - Custom UIs
  private lazy var createImageButton = BigBlueButton(frame: .zero)
  private lazy var searchImagesCV = SearchImagesCV(frame: .zero, collectionViewLayout: SearchImagesCVLayout())
  private lazy var emptyView = SelectedGoalsEmptyView()
  private lazy var searchController = UISearchController(searchResultsController: nil)
  private let goalsVC = GoalsSelectionViewController()
  
  private let viewModel = SearchImagesViewModel()
  private let selectImageViewModel = SelectionViewModel()
  weak var coordinator: MainCoordinator?
  var selectedImageDelegate : SelectedImageDelegate?
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupViews()
  }
  
  private func setupViews() {
    setupNavBar()
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
      searchImagesCV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      searchImagesCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ])
  }
  
  private func setupNavBar() {
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search for images"
    searchController.searchBar.autocorrectionType = .default
    searchController.searchBar.sizeToFit()
    
    navigationItem.title = "Search for a new image"
    navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Search Images")
    
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
  }
  
  private func setupBlueButton() {
    self.view.addSubview(createImageButton)
    createImageButton.setTitle("Create", for: .normal)
    createImageButton.addTarget(self, action: #selector(backToChooseImageVC), for: .touchUpInside)
    NSLayoutConstraint.activate([
      createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
      createImageButton.heightAnchor.constraint(equalToConstant: 50),
      createImageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    ])
  }
  
  @objc private func backToChooseImageVC() {
    if let image = viewModel.selectedImage {
      selectedImageDelegate?.passImageSelected(image: image)
    }
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - CollectionView Delegate
extension SearchImageViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let selectedCell = searchImagesCV.cellForItem(at: indexPath) as? SearchImagesCell else {
      return
    }
    viewModel.selectedImage = selectedCell.cellImage
  }
}

// MARK: - CollectionView DataSource
extension SearchImageViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.imageURLS.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = searchImagesCV.dequeueReusableCell(withReuseIdentifier: searchImagesCV.cellID, for: indexPath) as? SearchImagesCell else {
      return UICollectionViewCell()
    }

    let urlString = viewModel.imageURLS[indexPath.row].urls.regular

    viewModel.networkManager.getPhotoData(from: urlString) { result in
      switch result {
      case let .success(image):
        DispatchQueue.main.async {
          cell.getImage(image)
        }

      case let .failure(error):
        #if DEBUG
          print("Unable to get photo data for url: \(urlString)")
          print(error)
        #endif
      }
    }
    return cell
  }
}
// MARK: - SearchBar Delegate
extension SearchImageViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // set urls to empty for new search
    viewModel.imageURLS = []
    let keywords = searchBar.text
    guard let finalKeyword = keywords?.replacingOccurrences(of: " ", with: "+") else { return }
    viewModel.loadSearchURLS(for: finalKeyword, cv: searchImagesCV)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    dismiss(animated: true, completion: nil)
  }
}
