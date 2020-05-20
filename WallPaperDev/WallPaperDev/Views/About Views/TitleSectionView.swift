//
//  TitleSectionView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/19/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class TitleSectionView: UICollectionReusableView {
  let label = UILabel()
  static let reuseIdentifier = "title-supplementary-reuse-identifier"

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}

extension TitleSectionView {

  func removeLabel() {
    if label.superview == self {
      label.removeFromSuperview()
    }
  }

  func configure() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = 1
    let inset = CGFloat(10)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.heavy20
    label.text = Localized.string("developed_by")
    label.sizeToFit()
  }
}
