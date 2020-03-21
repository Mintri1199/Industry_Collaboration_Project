//
//  ImageSelectionCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

// (Jackson) - Might remove due to the recent UI resdesign
class ImageSelectionCell: UICollectionViewCell {
  // Using layers to hold non interactive images
  lazy var photoLayer = CALayer()
  lazy var maskLayer = CAShapeLayer()
  lazy var borderLayer = CAShapeLayer()
  lazy var showMoreTextLayer = CATextLayer()
  lazy var showMoreLayer = CAShapeLayer()
  let identifier = "cellID"
  var lastCell: Bool = false

  // MARK: - UIs
  var cellImage: UIImage? {
    didSet {
      photoLayer.contents = cellImage?.cgImage
    }
  }
}

// MARK: - Setup UI functions
extension ImageSelectionCell {
  func getImage(_ image: UIImage?) {
    photoLayer.frame = bounds
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

  func setupShowMoreViews() {
    setupLabel()
    setupButton()
    lastCell = true
  }

  private func setupLabel() {
    showMoreTextLayer.string = NSAttributedString(string: Localized.string("show_more_title"),
                                                  attributes: [NSAttributedString.Key.font: DefaultFontSchema().medium16,
                                                               NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    showMoreTextLayer.frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 20))
    showMoreTextLayer.alignmentMode = .center
    showMoreTextLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    layer.addSublayer(showMoreTextLayer)
  }

  private func setupButton() {
    let sizeConstant: CGFloat = bounds.width / 3
    showMoreLayer.frame = CGRect(origin: bounds.origin, size: CGSize(width: sizeConstant, height: sizeConstant))
    showMoreLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    showMoreLayer.position = CGPoint(x: bounds.midX, y: bounds.midY + showMoreLayer.frame.height)
    showMoreLayer.cornerRadius = sizeConstant / 2
    showMoreLayer.backgroundColor = UIColor.lightGray.cgColor

    let arrowPath = UIBezierPath.arrow(from: CGPoint(x: sizeConstant / 4, y: sizeConstant / 2),
                                       to: CGPoint(x: sizeConstant * 0.75, y: sizeConstant / 2),
                                       tailWidth: sizeConstant / 15, headWidth: sizeConstant / 4,
                                       headLength: sizeConstant / 6)

    showMoreLayer.strokeColor = UIColor.white.cgColor
    showMoreLayer.lineWidth = 3
    showMoreLayer.path = arrowPath.cgPath
    showMoreLayer.fillColor = UIColor.white.cgColor
    showMoreLayer.lineJoin = CAShapeLayerLineJoin.round
    showMoreLayer.lineCap = CAShapeLayerLineCap.round
    layer.addSublayer(showMoreLayer)
  }
}
