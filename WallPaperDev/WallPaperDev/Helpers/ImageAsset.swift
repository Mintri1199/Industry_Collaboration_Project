//
//  ImageAsset.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

// TODO: (alex) Introduce tests to ensure all assets are present if used
protocol ImageAsset {
  var actionButton: UIImage { get }
  var creditCard: UIImage { get }
  var disclosureIndicator: UIImage { get }
}

struct DefaultImageAsset: ImageAsset {
  var actionButton: UIImage {
    return #imageLiteral(resourceName: "2")
  }
  
  var creditCard: UIImage {
    return #imageLiteral(resourceName: "1")
  }
  
  var disclosureIndicator: UIImage {
    return #imageLiteral(resourceName: "3")
  }
}

