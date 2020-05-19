//  AboutViewController.swift
//  WallPaperDev
//
// Created by Jackson Ho on 5/9/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import UIKit
import SafariServices
// In this view controller I want to have the following functionalities
// * Deep linking to developers github profiles
// * Credits for borrowed assets
// *

class AboutViewController: UIViewController {
  enum Section: CaseIterable {
    case profiles, credits, libraries
  }
  
  enum ItemType {
    case profile(dev: DevProfile)
    case credit(text: NSAttributedString)
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
  
  //  let tableView = UITableView(frame: .zero, style: .insetGrouped)
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  //  private var dataSource: UITableViewDiffableDataSource<Section, Item>!
  //  private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Item>!
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
    let profileSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
    
    let profileItem = NSCollectionLayoutItem(layoutSize: profileSize)
    
    profileItem.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20)
    let profileGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(175))
    let profileGroup = NSCollectionLayoutGroup.horizontal(layoutSize: profileGroupSize, subitems: [profileItem])
    
    let profileSection = NSCollectionLayoutSection(group: profileGroup)
    
    let layout = UICollectionViewCompositionalLayout(section: profileSection)
    return layout
  }
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.register(DevProfileCell.self, forCellWithReuseIdentifier: DevProfileCell.id)
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
        
      default:
        return nil
      }
    })
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    snapshot.appendSections([.profiles])
    let profileItems = viewModel.devProfiles.compactMap { Item(type: .profile(dev: $0)) }
    snapshot.appendItems(profileItems, toSection: .profiles)
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// MARK: UI Methods
extension AboutViewController {
  
  func configureColletionView() {}
  
  //  func configureTableView() {
  //    self.view.addSubview(tableView)
  //    tableView.translatesAutoresizingMaskIntoConstraints = false
  //    tableView.estimatedRowHeight = 200
  //    tableView.separatorStyle = .none
  //    tableView.bounces = false
  //    tableView.rowHeight = UITableView.automaticDimension
  //    NSLayoutConstraint.activate([
  //      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
  //      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  //      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
  //      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
  //    ])
  //    tableView.register(AboutTableViewCell.self, forCellReuseIdentifier: AboutViewController.reuseIdentifier)
  //  }
  //
  //  private func configureDataSource() {
  //    self.dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { [weak self] (tableView: UITableView, _ : IndexPath, item: Item) -> UITableViewCell? in
  //      guard let self = self, let cell = tableView.dequeueReusableCell(withIdentifier: AboutViewController.reuseIdentifier) as? AboutTableViewCell else {
  //        return nil
  //      }
  //
  //      tableView.sectionHeaderHeight = 0
  //
  //      switch item.type {
  //      case .profile:
  //        // FLag: Color
  //        cell.backgroundColor = .yellow
  //        cell.prepareProfiles { collectionView in
  //          collectionView.delegate = self
  //        }
  //      case .credit:
  //        cell.prepare(type: .credits(text: self.viewModel.contructFeedbackText()))
  //      case .library:
  //        cell.prepare(type: .library(title: item.name ?? "", license: item.bodyText ?? ""))
  //      }
  //
  //      return cell
  //    }
  //  }
  //
  //  private func updateUI() {
  //    //
  //    currentSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
  //    let creditItem = Item(type: .credit)
  //    let licenseItems = viewModel.getLicenseMaterials().map { Item(type: .library(title: $0.0, license: $0.1)) }
  //    currentSnapshot.appendSections([.credits, .libraries])
  //    currentSnapshot.appendItems([creditItem], toSection: .credits)
  //    currentSnapshot.appendItems(licenseItems, toSection: .libraries)
  ////
  //    self.dataSource.apply(currentSnapshot, animatingDifferences: true)
  //  }
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
