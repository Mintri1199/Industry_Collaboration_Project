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

  lazy var cellImage = UIImage()

  fileprivate let loadingView = UIActivityIndicatorView()

  fileprivate lazy var photoLayer: CALayer = {
    var picture = CALayer()
    picture.frame = bounds
    picture.contentsGravity = .resizeAspectFill
    layer.masksToBounds = true
    return picture
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    loadingView.frame = bounds
    loadingView.style = .gray
    loadingView.hidesWhenStopped = true
    loadingView.startAnimating()
    contentView.addSubview(loadingView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func getImage(_ image: UIImage) {
    if photoLayer.superlayer != nil {
      photoLayer.removeFromSuperlayer()
    }
    layer.addSublayer(photoLayer)
    cellImage = image
    photoLayer.contents = cellImage.cgImage
    if loadingView.isAnimating {
      loadingView.stopAnimating()
    }
  }
}
