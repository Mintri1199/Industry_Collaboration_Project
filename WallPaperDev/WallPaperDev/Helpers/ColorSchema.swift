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

  var navBarBlue: UIColor { get }
  var sectionBlue: UIColor { get }
  var wallpaperBlue: UIColor { get }
  var backgroundOffWhite: UIColor { get }
  var foregroundWhite: UIColor { get }
  var placeholderGray: UIColor { get }
  var layerBackgroundWhite: UIColor { get }
  var addButtonRed: UIColor { get }
  var lightGray: UIColor { get }
  var darkGray: UIColor { get }
  var shadow: UIColor { get }
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

  ///rgba(84, 181, 237, 1)
  var navBarBlue: UIColor {
    return #colorLiteral(red: 0.33, green: 0.71, blue: 0.9294117647, alpha: 1)
  }

  ///rgba(56, 166, 230, 1)
  var sectionBlue: UIColor {
    return #colorLiteral(red: 0.22, green: 0.65, blue: 0.9, alpha: 1)
  }

  ///rgba(145, 230, 245, 1)
  var wallpaperBlue: UIColor {
    return #colorLiteral(red: 0.57, green: 0.9, blue: 0.96, alpha: 1)
  }

  ///rgba(235, 235, 235, 1)
  var backgroundOffWhite: UIColor {
    return #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
  }

  ///rgba(255, 255, 255, 1)
  var foregroundWhite: UIColor {
    return white
  }

  ///rgba(214, 214, 217, 1)
  var placeholderGray: UIColor {
    return #colorLiteral(red: 0.84, green: 0.84, blue: 0.85, alpha: 1)
  }

  ///rgba(255, 255, 255, 0.2)
  var layerBackgroundWhite: UIColor {
    return white.withAlphaComponent(0.2)
  }

  ///rgba(255, 112, 112, 1)
  var addButtonRed: UIColor {
    return #colorLiteral(red: 1, green: 0.4392156863, blue: 0.44, alpha: 1)
  }

  var lightGray: UIColor {
    .lightGray
  }

  var darkGray: UIColor {
    .darkGray
  }

  var shadow: UIColor {
    UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
  }
}
