//
//  WelcomeCellViews.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class FirstTwoCellView: UIView {
    
    private let photolayer = CALayer()
    private let headerLabel = WelcomeLabel(frame: .zero)
    private let subHeaderLabel = WelcomeLabel(frame: .zero)
    
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

class DemoView: UIView {
    private let headerText = "Be Creative"
    private let subHeaderText = "Create a beautiful wallpaper with your goals in it"
    private let containerLayer = CALayer()
    private let fingerLayer = CALayer()
    private let textLayer = CALayer()
    private let phoneLayer = CALayer()
    private let headerLabel = WelcomeLabel(frame: .zero)
    private let subHeaderLabel = WelcomeLabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetAnimation() {
        pauseAnimation()
        prepAnimation()
    }
    
    private func setupUI() {
        subHeaderLabel.configSubHeaderLabel(text: subHeaderText)
        subHeaderLabel.frame.size.width = bounds.width * 0.7
        subHeaderLabel.sizeToFit()
        subHeaderLabel.center = CGPoint(x: center.x, y: bounds.maxY - subHeaderLabel.frame.height / 2)
        
        headerLabel.configHeaderLabel(text: headerText)
        headerLabel.frame.size.width = bounds.width * 0.8
        headerLabel.sizeToFit()
        headerLabel.center = center
        headerLabel.center.y = subHeaderLabel.frame.minY - headerLabel.frame.height / 2
        
        addSubview(headerLabel)
        addSubview(subHeaderLabel)
    }
    
    private func setupLayers() {
        containerLayer.frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: bounds.height - headerLabel.frame.height - subHeaderLabel.frame.height))
        layer.addSublayer(containerLayer)
        
        let phoneSize = CGSize(width: containerLayer.bounds.width * 0.6, height: containerLayer.bounds.height)
        let phoneXOffset = bounds.width / 5
        phoneLayer.frame = CGRect(origin: CGPoint(x: phoneXOffset, y: 0), size: phoneSize)
        phoneLayer.contents = UIImage(named: "example1")?.cgImage
        phoneLayer.contentsGravity = .resizeAspect
        containerLayer.addSublayer(phoneLayer)
        
        let textSize = CGSize(width: phoneLayer.bounds.width * 0.8, height: phoneLayer.bounds.height * 0.2)
        textLayer.frame = CGRect(origin: CGPoint(x: phoneLayer.bounds.width / 10, y: phoneLayer.bounds.maxY - textSize.height - 30), size: textSize)
        textLayer.contents = UIImage(named: "goalText")?.cgImage
        textLayer.contentsGravity = .resizeAspect
        phoneLayer.addSublayer(textLayer)
        
        let fingerSize = CGSize(width: containerLayer.bounds.width / 2, height: containerLayer.bounds.width / 2)
        fingerLayer.frame = CGRect(origin: CGPoint(x: containerLayer.bounds.midX, y: containerLayer.bounds.midY), size: fingerSize)
        fingerLayer.contents = UIImage(named: "finger")?.cgImage
        fingerLayer.contentsGravity = .resizeAspect
        containerLayer.addSublayer(fingerLayer)
    }
    
    private func prepAnimation() {
        let textMoveDown = CABasicAnimation(keyPath: "position.y")
        textMoveDown.fromValue = phoneLayer.bounds.midY
        textMoveDown.toValue = CGAffineTransform.identity
        textMoveDown.duration = 0.7
        textMoveDown.timingFunction = CAMediaTimingFunction(name: .linear)
        textLayer.add(textMoveDown, forKey: nil)
        
        let fingerMoveDownUP = CABasicAnimation(keyPath: "position.y")
        fingerMoveDownUP.fromValue = CGAffineTransform.identity
        fingerMoveDownUP.toValue = phoneLayer.bounds.maxY
        fingerMoveDownUP.autoreverses = true
        fingerMoveDownUP.duration = 0.7
        textMoveDown.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        fingerLayer.add(fingerMoveDownUP, forKey: nil)
    }
}
