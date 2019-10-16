//
//  WelcomeCellViews.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeCellViews: UIView {
    
    private let photolayer = CALayer()
    let headerLabel = WelcomeLabel(frame: .zero)
    let subHeaderLabel = WelcomeLabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(_ header: String, _ subHeader: String) {
        headerLabel.configHeaderLabel(text: header)
        headerLabel.frame.size.width = bounds.width * 0.8
        headerLabel.sizeToFit()
        headerLabel.center = center
        headerLabel.center.y = center.y + (headerLabel.frame.height * 2)
        
        subHeaderLabel.configSubHeaderLabel(text: subHeader)
        subHeaderLabel.frame.size.width = bounds.width * 0.7
        subHeaderLabel.sizeToFit()
        subHeaderLabel.center = CGPoint(x: center.x, y: headerLabel.center.y + headerLabel.frame.height * 1.5)
        addSubview(headerLabel)
        addSubview(subHeaderLabel)
    }

    func setupPhotoLayer(_ image: UIImage) {
        photolayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.width))
        photolayer.contents = image.cgImage
        photolayer.contentsGravity = .resizeAspect
        layer.addSublayer(photolayer)
    }
}
