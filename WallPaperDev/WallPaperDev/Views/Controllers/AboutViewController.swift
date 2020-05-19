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
  
  static let reuseIdentifier = "reuse-identifier"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // FLAG: color
    view.backgroundColor = .white
    setupCollectionView()
    configureDataSource()
  }
}

// MARK: UICollectionViewCompositional Layout
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
      
      return section
    }
    
    return compositionLayout
  }
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.register(DevProfileCell.self, forCellWithReuseIdentifier: DevProfileCell.id)
    collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.id)
    collectionView.register(CreditCollectionViewCell.self, forCellWithReuseIdentifier: CreditCollectionViewCell.id)
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    collectionView.delegate = self
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
  
  func configureColletionView() {}
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
