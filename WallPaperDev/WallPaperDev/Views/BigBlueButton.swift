//
//  BigBlueButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class BigBlueButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        layer.cornerRadius = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
