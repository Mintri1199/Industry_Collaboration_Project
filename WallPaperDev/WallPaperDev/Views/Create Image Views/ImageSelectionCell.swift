//
//  ImageSelectionCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImageSelectionCell: UICollectionViewCell {
    let identifier = "cellID"
    var lastCell: Bool = false
    
    // MARK: - UIs
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
    
    lazy var showMoreButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cellImage: UIImage? = nil {
        didSet {
            photoLayer.contents = cellImage?.cgImage
        }
    }
    
    // Using layers to hold uninteractable images
    lazy var photoLayer = CALayer()
    lazy var maskLayer = CAShapeLayer()
    lazy var borderLayer = CAShapeLayer()
}

// MARK: - Setup UI functions
extension ImageSelectionCell {
    
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
    
    func setupShowMoreViews() {
        setupLabel()
        setupButton()
        lastCell = true
    }
    
    private func setupLabel() {
        addSubview(showMoreLabel)
        NSLayoutConstraint.activate([
            showMoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            showMoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            showMoreLabel.widthAnchor.constraint(equalTo: widthAnchor),
            showMoreLabel.heightAnchor.constraint(equalToConstant: bounds.size.height / 6)
            ])
    }
    
    private func setupButton() {
        addSubview(showMoreButton)
        
        let sizeContant: CGFloat = bounds.width / 3
        
        NSLayoutConstraint.activate([
            showMoreButton.heightAnchor.constraint(equalToConstant: sizeContant),
            showMoreButton.widthAnchor.constraint(equalToConstant: sizeContant),
            showMoreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showMoreButton.topAnchor.constraint(equalTo: showMoreLabel.bottomAnchor)
            ])
        
        showMoreButton.backgroundColor = .lightGray
        showMoreButton.layer.cornerRadius = sizeContant / 2
        
        // Draw an arrow layer instead of using a picture
        // Credit: Jake https://stackoverflow.com/questions/48625763/how-to-draw-a-directional-arrow-head
        let arrowPath = UIBezierPath()
        arrowPath.addArrow(start: CGPoint(x: sizeContant / 4, y: sizeContant / 2), end: CGPoint(x: sizeContant * 0.75, y: sizeContant / 2), pointerLineLength: sizeContant / 5, arrowAngle: CGFloat(Double.pi / 4))
        
        let arrowLayer = CAShapeLayer()
        arrowLayer.strokeColor = UIColor.white.cgColor
        arrowLayer.lineWidth = 3
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.lineJoin = CAShapeLayerLineJoin.round
        arrowLayer.lineCap = CAShapeLayerLineCap.round
        showMoreButton.layer.addSublayer(arrowLayer)
    }
}
