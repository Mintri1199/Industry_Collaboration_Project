//
//  Localized.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

final class Localized {
  static func string(_ key: String,
                     comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
  }
}
