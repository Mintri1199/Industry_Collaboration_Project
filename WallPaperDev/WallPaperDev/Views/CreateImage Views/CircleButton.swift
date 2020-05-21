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
    addShadow(width: 0, height: 2, opacity: 0.75, radius: 2)
  }
  
  func setupIcon(for icon: IconEnum) {
    
    switch icon {
    case .camera:
      let image = UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysTemplate)
      tintColor = ApplicationDependency.manager.currentTheme.colors.darkGray
      self.imageView?.contentMode = .scaleAspectFit
      setImage(image, for: .normal)
      self.contentHorizontalAlignment = .fill
      self.contentVerticalAlignment = .fill
      self.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    case .unsplash:
      let logo = ApplicationDependency.manager.currentTheme.imageAssets.unsplashLogo.withRenderingMode(.alwaysTemplate)
      tintColor = ApplicationDependency.manager.currentTheme.colors.darkGray
      self.imageView?.contentMode = .scaleAspectFit
      setImage(logo, for: .normal)
    }
    
    backgroundColor = ApplicationDependency.manager.currentTheme.colors.white
  }
}
