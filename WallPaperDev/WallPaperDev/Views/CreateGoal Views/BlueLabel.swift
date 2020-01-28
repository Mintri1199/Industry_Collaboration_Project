//
//  BlueLabel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class BlueLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        adjustsFontSizeToFitWidth = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
