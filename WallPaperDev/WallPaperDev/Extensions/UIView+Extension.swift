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

  func addShadow(width: CGFloat, height: CGFloat, opacity: Float, radius: CGFloat) {
    layer.shadowColor = ApplicationDependency.manager.currentTheme.colors.shadow.cgColor
    layer.shadowOffset = CGSize(width: width, height: height)
    layer.shadowOpacity = opacity
    layer.shadowRadius = radius
    layer.masksToBounds = false
  }
}
