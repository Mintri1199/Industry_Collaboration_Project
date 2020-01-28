//
//  BigBlueButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class BigBlueButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    titleLabel?.adjustsFontSizeToFitWidth = true
    setTitleColor(.white, for: .normal)
    setTitleColor(.lightGray, for: .highlighted)
    backgroundColor = .sectionBlue
    layer.cornerRadius = 25
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
