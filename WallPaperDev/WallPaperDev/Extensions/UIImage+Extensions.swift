//
//  UIImage+Extensions.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/25/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

extension UIImage {
  static func templateIcon(for id: String) -> UIImage? {
    return UIImage(systemName: id)?.withRenderingMode(.alwaysTemplate)
  }
}
