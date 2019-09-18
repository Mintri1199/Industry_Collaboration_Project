//
//  ImageSelectionCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImageSelectionCell: UICollectionViewCell {
    
    var image: UIImage? = nil {
        didSet {
            photoLayer.contents = image?.cgImage
        }
    }
    
    // Using layer to hold uninteractable images
    let photoLayer = CALayer()
    let maskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(photoLayer)
        photoLayer.backgroundColor = UIColor.red.cgColor
        photoLayer.frame = bounds
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.width / 5).cgPath
        layer.mask = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
