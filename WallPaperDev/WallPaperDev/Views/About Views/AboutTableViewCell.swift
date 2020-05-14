//
// Created by Jackson Ho on 5/13/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

final class AboutTableViewCell: UITableViewCell {

  enum CellType {
    case credits(text: String)
    case library(title: String, license: String)
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.black32
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.textAlignment = .left
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var bodyTextLabel: UILabel = {
    let label = UILabel()
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium16
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var profileCollectionView = DevProfileCollectionView()

  func prepareProfiles(completion: (UICollectionView) -> Void) {
    profileCollectionView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3))
    addSubview(profileCollectionView)
    NSLayoutConstraint.activate([
      profileCollectionView.topAnchor.constraint(equalTo: topAnchor),
      profileCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      profileCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    completion(profileCollectionView)
  }

  func prepare(type: CellType) {
    switch type {
    case let .credits(text):
      bodyTextLabel.frame = bounds
      addSubview(bodyTextLabel)
      bodyTextLabel.text = text
      bodyTextLabel.sizeToFit()
    case let .library(title, license):
      titleLabel.text = title
      setupTitleLabel()
      bodyTextLabel.text = license
      setupBodyTextLabel()
    }
  }

  private func setupTitleLabel() {
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
    titleLabel.sizeToFit()
  }

  private func setupBodyTextLabel() {
    addSubview(bodyTextLabel)
    NSLayoutConstraint.activate([
      bodyTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      bodyTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      bodyTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      bodyTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
    bodyTextLabel.sizeToFit()
  }
}
