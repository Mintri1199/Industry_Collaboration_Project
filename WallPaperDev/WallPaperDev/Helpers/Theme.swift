//
//  Theme.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

struct Theme {
  let colors: ColorSchema
  let imageAssets: ImageAsset
  let fontSchema: FontSchema
  
  init(colors: ColorSchema = DefaultColors(),
       imageAssets: ImageAsset = DefaultImageAsset(),
       fontSchema: FontSchema = DefaultFontSchema()) {
    self.colors = colors
    self.imageAssets = imageAssets
    self.fontSchema = fontSchema
  }
}
