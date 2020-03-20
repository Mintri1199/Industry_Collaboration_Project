//
//  SearchImageViewController.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol SelectedImageDelegate: class {
  func passImageSelected(image: UIImage)
}

final class SearchImageViewController: UIViewController {
  // MARK: - Custom UIs
  private lazy var searchImagesCV = SearchImagesCV(frame: .zero, collectionViewLayout: SearchImagesCVLayout())
  private lazy var emptyView = SelectedGoalsEmptyView()
  private lazy var searchController = UISearchController(searchResultsController: nil)
  private let goalsVC = GoalsSelectionViewController()
  private let viewModel = SearchImagesViewModel()
  weak var coordinator: MainCoordinator?
  weak var delegate: SelectedImageDelegate?
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
    setupViews()
  }
}

// MARK: - UI setup methods
// TODO: Implement Context menu for when the user hold on the cell
extension SearchImageViewController {
  
  private func setupViews() {
    setupNavBar()
    setupImageCollectionView()
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
    searchController.searchBar.placeholder = Localized.string("unsplash_searchbar_placeholder")
    searchController.searchBar.autocorrectionType = .default
    searchController.searchBar.sizeToFit()
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
  }
}

// MARK: objc methods
extension SearchImageViewController {
  @objc private func backToChooseImageVC() {
    if let image = viewModel.selectedImage {
      delegate?.passImageSelected(image: image)
    }
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - CollectionView Delegate
extension SearchImageViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let selectedCell = searchImagesCV.cellForItem(at: indexPath) as? SearchImagesCell else {
      return
    }
    
    delegate?.passImageSelected(image: selectedCell.cellImage)
    navigationController?.popViewController(animated: true)
  }
  
  @available(iOS 13.0, *)
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let config = UIContextMenuConfiguration(identifier: nil, previewProvider: {
      guard let cell = collectionView.cellForItem(at: indexPath) as? SearchImagesCell else {
        return nil
      }
      
      return UnsplashPreviewVC(photo: cell.cellImage)
    }, actionProvider: { _ in
      
      let chooseAction = UIAction(title: "Choose") { _ in
      }
      
      let menu = UIMenu(title: "", image: nil, options: [], children: [chooseAction])
      
      return menu
    })
    return config
  }
}

// MARK: - CollectionView DataSource
extension SearchImageViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.imageURLS.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = searchImagesCV.dequeueReusableCell(withReuseIdentifier: searchImagesCV.cellID, for: indexPath) as? SearchImagesCell else {
      return UICollectionViewCell()
    }
    
    let urlString = viewModel.imageURLS[indexPath.row].urlString
    
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
extension SearchImageViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.loadSearchURLS(for: searchBar.text, cv: searchImagesCV)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    dismiss(animated: true, completion: nil)
  }
}
