//
//  LibraryCollectionViewCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/19/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
  static var id = "libraryCell"
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.black32
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.numberOfLines = 1
    label.adjustsFontSizeToFitWidth = true
    return label
  }()

  private lazy var licenceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium16
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    return label
  }()

  func prepare(title: String, bodyText: String) {
    titleLabel.text = title
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    titleLabel.sizeToFit()

    licenceLabel.text = bodyText
    addSubview(licenceLabel)
    NSLayoutConstraint.activate([
      licenceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      licenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      licenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      licenceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    licenceLabel.sizeToFit()
  }
}
