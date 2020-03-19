//
//  SearchImagesCell.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 12/3/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

final class SearchImagesCell: UICollectionViewCell {
  let identifier = "searchCell"

  lazy var photoLayer: CALayer = {
    var picture = CALayer()
    picture.frame = bounds
    picture.contentsGravity = .resizeAspectFill
    layer.masksToBounds = true
    return picture
  }()

  var cellImage: UIImage? {
    didSet {
      photoLayer.contents = cellImage?.cgImage
    }
  }

  func getImage(_ image: UIImage?) {
    if photoLayer.superlayer != nil {
      photoLayer.removeFromSuperlayer()
    }
    layer.addSublayer(photoLayer)

    if let image = image {
      cellImage = image
    }
  }
}
