//
//  BigBlueButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class BigBlueButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        setTitleColor(.white, for: .normal)
        setTitleColor(.darkGray, for: .highlighted)
        backgroundColor =  .sectionBlue
        layer.cornerRadius = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
