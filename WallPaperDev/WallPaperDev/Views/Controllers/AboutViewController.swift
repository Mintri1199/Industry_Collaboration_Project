//  AboutViewController.swift
//  WallPaperDev
//
// Created by Jackson Ho on 5/9/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

// In this view controller I want to have the following functionalities
// * Deep linking to developers github profiles
// * Credits for borrowed assets
// *
class AboutViewController: UIViewController {
  enum Section: CaseIterable {
    case profiles, credits, libraries
  }

  enum ItemType {
    case profile
    case text(bodyText: String)
    case library(title: String, license: String)
  }

  struct Item: Hashable {

    let name: String?
    let type: ItemType
    let bodyText: String?

    init(type: ItemType) {
      self.type = type
      switch type {
      case .profile:
        self.name = nil
        self.bodyText = nil
      case let .text(bodyText):
        self.bodyText = bodyText
        self.name = nil
      case let .library(title, license):
        self.name = title
        self.bodyText = license
      }
    }

    private let identifier = UUID()
    func hash(into hasher: inout Hasher) {
      hasher.combine( self.identifier)
    }

    static func == (lhs: AboutViewController.Item, rhs: AboutViewController.Item) -> Bool {
      return lhs.identifier == rhs.identifier
    }
  }

  let tableView = UITableView(frame: .zero, style: .insetGrouped)
  private var dataSource: UITableViewDiffableDataSource<Section, Item>!
  private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  private let viewModel = AboutViewModel()
  static let reuseIdentifier = "reuse-identifier"

  override func viewDidLoad() {
    super.viewDidLoad()
    // FLAG: color
    view.backgroundColor = .white
    configureTableView()
    configureDataSource()
    updateUI()
  }
}

extension AboutViewController {

  func configureTableView() {
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.estimatedRowHeight = 200
    tableView.separatorStyle = .none

    tableView.rowHeight = UITableView.automaticDimension
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    tableView.register(AboutTableViewCell.self, forCellReuseIdentifier: AboutViewController.reuseIdentifier)
  }

  private func configureDataSource() {
    self.dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { [weak self] (tableView: UITableView, _ : IndexPath, item: Item) -> UITableViewCell? in
      guard let self = self, let cell = tableView.dequeueReusableCell(withIdentifier: AboutViewController.reuseIdentifier) as? AboutTableViewCell else {
        return nil
      }

      switch item.type {
      case .profile:
        // FLag: Color
        cell.backgroundColor = .yellow
        cell.prepareProfiles { collectionView in
          collectionView.delegate = self
        }
      case .text:
        cell.prepare(type: .credits(text: item.bodyText ?? ""))
      case .library:
        cell.prepare(type: .library(title: item.name ?? "", license: item.bodyText ?? ""))
      }

      return cell
    }
  }

  private func updateUI() {
    currentSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()

    let licenseItems = viewModel.getLicenseMaterials().map { Item(type: .library(title: $0.0, license: $0.1)) }
    currentSnapshot.appendSections([.libraries])
    currentSnapshot.appendItems(licenseItems, toSection: .libraries)

    self.dataSource.apply(currentSnapshot, animatingDifferences: true)
  }
}

extension AboutViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Print")
  }
}
