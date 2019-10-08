//
//  BlueLabel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class BlueLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        textColor =  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
