//
//  BigBlueButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

final class BigBlueButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    // TODO: Flagging font
    titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    titleLabel?.adjustsFontSizeToFitWidth = true
    setTitleColor(.white, for: .normal)
    setTitleColor(.lightGray, for: .highlighted)
    backgroundColor =  ApplicationDependency.manager.currentTheme.colors.sectionBlue
    layer.cornerRadius = 25
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
