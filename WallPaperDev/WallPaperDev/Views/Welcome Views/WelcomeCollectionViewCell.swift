//
//  WelcomeCollectionViewCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/17/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
  var containerView: UIView? {
    didSet {
      addSubview(containerView ?? UIView())
    }
  }
}
