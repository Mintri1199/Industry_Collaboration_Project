//
//  CircleButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 3/18/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

enum IconEnum {
  case unsplash
  case camera
}

final class CircleButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupBorder(_ corner: CGFloat) {
    layer.cornerRadius = corner / 2
    layer.shadowColor = ApplicationDependency.manager.currentTheme.colors.shadow.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2.5)
    layer.shadowOpacity = 0.75
    layer.shadowRadius = 3.0
    layer.masksToBounds = false
  }
  
  func setupIcon(for icon: IconEnum) {
    
    switch icon {
    case .camera:
      let image = ApplicationDependency.manager.currentTheme.imageAssets.backgroundPreviewCamera.withRenderingMode(.alwaysTemplate)
      tintColor = ApplicationDependency.manager.currentTheme.colors.darkGray
      self.imageView?.contentMode = .scaleAspectFit
      setImage(image, for: .normal)
    case .unsplash:
      let logo = ApplicationDependency.manager.currentTheme.imageAssets.unsplashLogo.withRenderingMode(.alwaysTemplate)
      tintColor = ApplicationDependency.manager.currentTheme.colors.black
      self.imageView?.contentMode = .scaleAspectFit
      setImage(logo, for: .normal)
    }
    
    backgroundColor = ApplicationDependency.manager.currentTheme.colors.white
  }
}
