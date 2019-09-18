//
//  ImageSelectionCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImageSelectionCell: UICollectionViewCell {
    
    // MARK: - UIs
    let showMoreLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Show more"
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let showMoreButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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

// MARK: - Setup UI functions
extension ImageSelectionCell {
    
    func setupShowMoreViews() {
        photoLayer.removeFromSuperlayer()
        layer.mask = nil
        setupLabel()
        setupButton()
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
