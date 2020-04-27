//
//  PaddingLabel.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
  private let insets = UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15)

  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + insets.left + insets.right,
                  height: size.height + insets.top + insets.bottom)
  }

  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: insets))
  }
}
