//
//  ColorSchema.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol ColorSchema {
  // MARK: - Primary Colors
  var black: UIColor { get }
  var white: UIColor { get }

  // MARK: - Other Colors
}

struct DefaultColors: ColorSchema {
  // MARK: - Primary Colors

  ///rgba(0, 0, 0, 1)
  var black: UIColor {
    return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  }

  ///rgba(255, 255, 255, 1)
  var white: UIColor {
    return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
}
