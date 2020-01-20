//
//  ApplicationDependency.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

final class ApplicationDependency {
  static let manager = ApplicationDependency()
  let currentTheme = Theme()

  private init() {
    // No-op - if needed setup global app state tracking
  }
}
