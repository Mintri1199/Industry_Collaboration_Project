//
//  SearchImagesCell.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

final class SearchImagesCell: UICollectionViewCell {
  let identifier = "searchCell"
  
  // Using layers to hold uninteractable images
  lazy var photoLayer = CALayer()
  lazy var maskLayer = CAShapeLayer()
  lazy var borderLayer = CAShapeLayer()
  
  var cellImage: UIImage? {
    didSet {
      photoLayer.contents = cellImage?.cgImage
    }
  }
  
  func getImage(_ image: UIImage?) {
    photoLayer.backgroundColor = UIColor.red.cgColor
    photoLayer.frame = bounds
    photoLayer.contentsGravity = .resizeAspect
    maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.width / 5).cgPath
    
    borderLayer.frame = bounds
    borderLayer.path = maskLayer.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.lineWidth = 0
    borderLayer.strokeColor = UIColor.green.cgColor
    
    photoLayer.mask = maskLayer
    layer.addSublayer(photoLayer)
    layer.addSublayer(borderLayer)
    
    if let image = image {
      cellImage = image
    }
  }
}
