//
//  SearchImagesCell.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class SearchImagesCell : UICollectionViewCell {
    let identifier = "searchCell"
   
    lazy var showMoreLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Show more"
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupLabel() {
        addSubview(showMoreLabel)
        NSLayoutConstraint.activate([
            showMoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            showMoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            showMoreLabel.widthAnchor.constraint(equalTo: widthAnchor),
            showMoreLabel.heightAnchor.constraint(equalToConstant: bounds.size.height / 6)
            ])
    }
    
    // Using layers to hold uninteractable images
    lazy var photoLayer = CALayer()
    lazy var maskLayer = CAShapeLayer()
    lazy var borderLayer = CAShapeLayer()
    
    var cellImage: UIImage? = nil {
        didSet {
            photoLayer.contents = cellImage?.cgImage
        }
    }
    
    func getImage(_ image: UIImage?) {
        photoLayer.backgroundColor = UIColor.red.cgColor
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
    

}













