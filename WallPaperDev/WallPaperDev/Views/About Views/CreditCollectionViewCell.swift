//
//  CreditCollectionViewCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/19/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreditCollectionViewCell: UICollectionViewCell {
  static var id = "creditCell"
  private var textView: UITextView = {
    let view = UITextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textAlignment = .natural
    view.isEditable = false
    view.isScrollEnabled = false
    return view
  }()

  func prepare(text: NSAttributedString) {
    textView.attributedText = text
    textView.font = ApplicationDependency.manager.currentTheme.fontSchema.medium20
    textView.textColor = ApplicationDependency.manager.currentTheme.colors.black
    addSubview(textView)
    NSLayoutConstraint.activate([
      textView.topAnchor.constraint(equalTo: topAnchor),
      textView.leadingAnchor.constraint(equalTo: leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: trailingAnchor),
      textView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    textView.sizeToFit()
    sizeToFit()
  }

//  override var intrinsicContentSize: CGSize {
//    let _ = super.intrinsicContentSize
//    return textView.bounds.size
//  }
}
