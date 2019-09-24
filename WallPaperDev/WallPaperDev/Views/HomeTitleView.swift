//
//  HomeTitleView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HomeTitleView: UIView {
    
    let morningTitleLabel: UILabel = {  
        let label = UILabel()
        label.text = "Good Morning"
        label.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Avenir-Black", size: 40)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        addSubview(morningTitleLabel)
        titleConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleConstraint() {
        
        morningTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        morningTitleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 4).isActive = true
        morningTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 10).isActive = true
        morningTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        morningTitleLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

