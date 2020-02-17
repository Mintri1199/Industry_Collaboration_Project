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
  private lazy var chooseImageLabel = BlueLabel(frame: .zero)
  private lazy var chooseGoalLabel = BlueLabel(frame: .zero)
  private lazy var searchImagesCV = SearchImagesCV(frame: .zero, collectionViewLayout: SearchImagesCVLayout())
  private lazy var goalsTableView = GoalsTableView(frame: .zero, style: .plain)
  private lazy var changeGoalsButton = GrayTextButton(frame: .zero)
  private lazy var emptyView = SelectedGoalsEmptyView()
  private let goalsVC = GoalsSelectionViewController()
  private let viewModel = SearchImagesViewModel()
  private let selectImageViewModel = SelectionViewModel()
  private lazy var searchController = UISearchController(searchResultsController: nil)
  
  var selectedImageDelegate : SelectedImageDelegate?
  
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
  
  private func getImageURLs(from keyword: String) {
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    
    NetworkingService.shared.getData(parameters: ["client_id": Keys.clientID ,"query": "\(keyword)" ,"per_page": "10"],completion: { data in
      do {
        let photos = try JSONDecoder().decode(NewPhotos.self, from: data)
        
        for user in photos.results {
          self.viewModel.imageURLS.append(user.urls.regular)
        }
        DispatchQueue.main.async {
          self.searchImagesCV.reloadData()
        }
      } catch {
        print(error)
      }
            })
  }
  
  @objc private func backToChooseImageVC() {
    if let image = viewModel.selectedImage {
      selectedImageDelegate?.passImageSelected(image: image)
    }
    navigationController?.popViewController(animated: true)
  }
}

extension SearchImageViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    searchImagesCV.indexPathsForVisibleItems.forEach { index in
      if index != indexPath {
        if let otherCell = searchImagesCV.cellForItem(at: index) as? SearchImagesCell {
          otherCell.borderLayer.lineWidth = 0
        }
      } else {
        if let selectedCell = searchImagesCV.cellForItem(at: index) as? SearchImagesCell {
          selectedCell.borderLayer.lineWidth = 5
          viewModel.selectedImage = selectedCell.cellImage
        }
      }
    }
  }
}

extension SearchImageViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.imageURLS.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = searchImagesCV.dequeueReusableCell(withReuseIdentifier: searchImagesCV.cellID, for: indexPath) as? SearchImagesCell else {
      return UICollectionViewCell()
    }
    
    guard let photoData = viewModel.imageURLS[indexPath.row] else {
      return cell
    }
    
    NetworkingService.shared.getPhoto(from: photoData) { data in
      let newImage = UIImage(data: data)
      DispatchQueue.main.async {
        cell.getImage(newImage)
      }
    }
    return cell
  }
}

extension SearchImageViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // set urls to empty for new search
    viewModel.imageURLS = []
    let keywords = searchBar.text
    guard let finalKeyword = keywords?.replacingOccurrences(of: " ", with: "+") else {return}
    getImageURLs(from: finalKeyword)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    dismiss(animated: true, completion: nil)
  }
}
