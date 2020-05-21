//  AboutViewController.swift
//  WallPaperDev
//
// Created by Jackson Ho on 5/9/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController {
  
  enum Section: Int, CaseIterable {
    case profiles, feedback, libraries
    
    var columnCount: Int {
      switch self {
      case .profiles:
        return 2
      default:
        return 1
      }
    }
  }
  
  enum ItemType {
    case profile(dev: DevProfile)
    case feedback(text: NSAttributedString)
    case library(title: String, license: String)
  }
  
  // CollectionViewCompositional Item object
  struct Item: Hashable {
    
    private(set) var type: ItemType
    private let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
      hasher.combine( self.identifier)
    }
    
    static func == (lhs: AboutViewController.Item, rhs: AboutViewController.Item) -> Bool {
      return lhs.identifier == rhs.identifier
    }
  }
  
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  private let viewModel = AboutViewModel()
  weak var coordinator: MainCoordinator?
  static let sectionHeaderElementKind = "section-header-element-kind"
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ApplicationDependency.manager.currentTheme.colors.white
    setupNavBar()
    setupCollectionView()
    configureDataSource()
  }
}

// MARK: DifferableDataSource and CompositionalLayout
extension AboutViewController {
  private func createLayout() -> UICollectionViewLayout {
    let compositionLayout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _ : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      guard let sectionLayoutKind = Section(rawValue: sectionIndex) else {
        return nil
      }
      let columns = sectionLayoutKind.columnCount
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: columns == 1 ? .estimated(250) : .fractionalHeight(1.0))
      
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(175))
      
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
      group.interItemSpacing = .fixed(20)
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 20
      section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
      
      let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(10))
      
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: sectionHeaderSize,
        elementKind: AboutViewController.sectionHeaderElementKind, alignment: .top)
      
      section.boundarySupplementaryItems = [sectionHeader]
      return section
    }
    
    return compositionLayout
  }
  
  private func configureDataSource() {
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      switch item.type {
      case let .profile(dev):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DevProfileCell.id, for: indexPath) as? DevProfileCell else {
          return nil
        }
        cell.prepare(for: dev)
        return cell
        
      case let .feedback(text: string):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditCollectionViewCell.id, for: indexPath) as? CreditCollectionViewCell else {
          return nil
        }
        cell.prepare(text: string)
        return cell
        
      case let .library(title, license):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.id, for: indexPath) as? LibraryCollectionViewCell else {
          return nil
        }
        cell.prepare(title: title, bodyText: license)
        return cell
      }
    })
    
    dataSource.supplementaryViewProvider = { ( collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: TitleSectionView.reuseIdentifier,
        for: indexPath) as? TitleSectionView else { fatalError("Cannot create new supplementary") }
      
      (indexPath.section == 0 && kind == AboutViewController.sectionHeaderElementKind) ? nil : supplementaryView.removeLabel()
      
      return supplementaryView
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    snapshot.appendSections([.profiles, .feedback, .libraries])
    let profileItems = viewModel.devProfiles.compactMap { Item(type: .profile(dev: $0)) }
    snapshot.appendItems(profileItems, toSection: .profiles)
    
    let feedbackItem = Item(type: .feedback(text: viewModel.contructFeedbackText()))
    snapshot.appendItems([feedbackItem], toSection: .feedback)
    
    let libraryItems = viewModel.getLicenseMaterials().compactMap { Item(type: .library(title: $0, license: $1)) }
    snapshot.appendItems(libraryItems, toSection: .libraries)
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// MARK: UI Methods
extension AboutViewController {
  
  private func setupNavBar() {
    coordinator?.navigationController.setNavigationBarHidden(false, animated: true)
    navigationItem.title = Localized.string("credits")
    coordinator?.navigationController.navigationBar.prefersLargeTitles = false
  }
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.register(DevProfileCell.self, forCellWithReuseIdentifier: DevProfileCell.id)
    collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.id)
    collectionView.register(CreditCollectionViewCell.self, forCellWithReuseIdentifier: CreditCollectionViewCell.id)
    collectionView.register(TitleSectionView.self, forSupplementaryViewOfKind: AboutViewController.sectionHeaderElementKind, withReuseIdentifier: TitleSectionView.reuseIdentifier)
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    collectionView.delegate = self
  }
}

extension AboutViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard (collectionView.cellForItem(at: indexPath) as? DevProfileCell) != nil else {
      return
    }
    
    let safariVC = SFSafariViewController(url: URL(string: viewModel.devProfiles[indexPath.row].githubUrlString)!)
    safariVC.modalPresentationStyle = .fullScreen
    present(safariVC, animated: true, completion: nil)
  }
}
