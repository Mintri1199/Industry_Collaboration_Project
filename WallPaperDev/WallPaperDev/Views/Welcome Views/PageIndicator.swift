//
//  PageIndicator.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

private class PageIndicator: UIView {
    
    let circleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 15, height: 15)))
        circleLayer.fillColor = UIColor.white.cgColor
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        circleLayer.path = UIBezierPath(ovalIn: frame).cgPath
        let mask = CAShapeLayer()
        circleLayer.strokeColor = UIColor.darkGray.cgColor
        circleLayer.lineWidth = 3
        layer.addSublayer(circleLayer)
        
        mask.path = circleLayer.path
        layer.mask = mask
    }
}

class PageIndicators: UIStackView {

    private var pageOne: PageIndicator = {
        let view = PageIndicator()
        view.circleLayer.lineWidth = 0
        view.circleLayer.fillColor = UIColor.navBarBlue.cgColor
        return view
    }()
    
    private let pageTwo = PageIndicator()
    private let pageThree = PageIndicator()
    private let pageFour = PageIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        distribution = .fillEqually
        spacing = 5
        config()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        addArrangedSubview(pageOne)
        addArrangedSubview(pageTwo)
        addArrangedSubview(pageThree)
        addArrangedSubview(pageFour)
    }
    
    func selectPage(at index: Int, prev: Int) {
        guard let selectedView = arrangedSubviews[index] as? PageIndicator, let deselectView = arrangedSubviews[prev] as? PageIndicator else {
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            selectedView.circleLayer.lineWidth = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                selectedView.circleLayer.fillColor = UIColor.navBarBlue.cgColor
            })
        })
        
        UIView.animate(withDuration: 0.1, animations: {
            deselectView.circleLayer.fillColor = UIColor.white.cgColor
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                deselectView.circleLayer.lineWidth = 3
            })
        })
    }
}
