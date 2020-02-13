//
//  WelcomeLabel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeLabel: UILabel {
  private let fontSchema = DefaultFontSchema()

  override init(frame: CGRect) {
    super.init(frame: frame)
    textAlignment = .center
    backgroundColor = .white
    adjustsFontSizeToFitWidth = true
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configHeaderLabel(text: String) {
    self.text = text
    numberOfLines = 1
    font = fontSchema.black32
    textColor = .darkGray
  }

  func configSubHeaderLabel(text: String) {
    self.text = text
    numberOfLines = 0
    font = fontSchema.medium20
    textColor = UIColor.gray
  }
}
