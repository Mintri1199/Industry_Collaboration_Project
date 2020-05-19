//
//  DevProfileCollectionView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/12/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class DevProfileCollectionView: UICollectionView {
  // TODO: Replace with array of Developer objects

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.heavy24
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.textAlignment = .left
    label.text = Localized.string("app_name")
    return label
  }()

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: DevProfileLayout())
    translatesAutoresizingMaskIntoConstraints = false
    // FLAG: Color
    backgroundColor = .green
    allowsMultipleSelection = false
    dataSource = self
    delegate = self
    register(DevProfileCell.self, forCellWithReuseIdentifier: DevProfileCell.id)
    sizeToFit()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DevProfileCollectionView: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
//    return developers.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DevProfileCell.id, for: indexPath) as? DevProfileCell else {
      return UICollectionViewCell()
    }

    cell.backgroundColor = .red
//    cell.prepare(name: developers[indexPath.row])
    return cell
  }

  //  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
  //    switch kind {
  //      case UICollectionView.elementKindSectionHeader:
  //      <#code#>
  //      default:
  //      <#code#>
  //    }
  //  }
}

extension DevProfileCollectionView: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Either launch webview of github profile or go into the github app and pull up profile there
//    print(developers[indexPath.row])
  }
}
