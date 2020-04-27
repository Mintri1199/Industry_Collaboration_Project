//
//  PaddingTextField.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/19/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
  private let insets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + insets.left + insets.right,
                  height: size.height + insets.top + insets.bottom)
  }
  
  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    textAlignment = .natural
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 10
    layer.borderWidth = 1
    layer.cornerRadius = 5
    layer.borderColor = ApplicationDependency.manager.currentTheme.colors.lightGray.cgColor
    
    font = ApplicationDependency.manager.currentTheme.fontSchema.medium20
    placeholder = Localized.string("milestone_placeholder")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }
}
