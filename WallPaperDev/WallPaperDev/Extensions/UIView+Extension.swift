//
//  UIView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/17/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  // TODO: (Jackson) I don't think we'll be needing this anymore
  func pauseAnimation() {
    let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
    layer.speed = 0
    layer.timeOffset = pausedTime
  }

  func resumeAnimation() {
    let pausedTime = layer.timeOffset
    layer.speed = 1
    layer.timeOffset = 0
    layer.beginTime = 0
    let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    layer.beginTime = timeSincePause
  }
}
