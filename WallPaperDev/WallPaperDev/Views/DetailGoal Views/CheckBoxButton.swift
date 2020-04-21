//
//  CheckBoxButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/15/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.borderColor = ApplicationDependency.manager.currentTheme.colors.lightGray.cgColor
    layer.borderWidth = 1.5
    layer.cornerRadius = 5
    let checkMark = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
    setImage(checkMark!, for: .selected)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
