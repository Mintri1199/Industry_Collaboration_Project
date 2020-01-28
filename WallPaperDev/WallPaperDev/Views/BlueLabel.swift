//
//  BlueLabel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class BlueLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    textAlignment = .left
    textColor = .sectionBlue
    font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    adjustsFontSizeToFitWidth = true
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
