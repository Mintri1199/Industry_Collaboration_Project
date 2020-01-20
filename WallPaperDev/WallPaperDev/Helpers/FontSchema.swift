//
//  FontSchema.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

enum FontStyle {
  case medium
  case heavy
  case black
}

protocol FontSchema {
  // MARK: Basic fonts
  var medium16: UIFont { get }
  var medium20: UIFont { get }
  var medium24: UIFont { get }

  var heavy20: UIFont { get }
  var heavy24: UIFont { get }

  var black32: UIFont { get }
  var black40: UIFont { get }

  // MARK: Font templates
  var titleRegular: UIFont { get }
}

struct DefaultFontSchema: FontSchema {
  // MARK: Basic fonts
  var medium16: UIFont {
    return font(style: .medium, size: 16)
  }

  var medium20: UIFont {
    return font(style: .medium, size: 20)
  }

  var medium24: UIFont {
    return font(style: .medium, size: 24)
  }

  var heavy20: UIFont {
    return font(style: .heavy, size: 20)
  }

  var heavy24: UIFont {
    return font(style: .heavy, size: 24)
  }

  var black32: UIFont {
    return font(style: .black, size: 32)
  }

  var black40: UIFont {
    return font(style: .black, size: 40)
  }

  // MARK: Font templates
  var titleRegular: UIFont {
    return heavy24
  }

  private func font(size: CGFloat) -> UIFont {
    return font(style: .medium, size: size)
  }

  private func font(style: FontStyle, size: CGFloat) -> UIFont {
    var name: String
    switch style {
    case .medium:
      name = "Avenir-Medium"

    case .heavy:
      name = "Avenir-Heavy"

    case .black:
      name = "Avenir-Black"
    }
    return UIFont(name: name, size: size)!
  }
}

