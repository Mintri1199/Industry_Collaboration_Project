//
//  CompleteImageVIew.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/18/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CompleteImageVIew: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
