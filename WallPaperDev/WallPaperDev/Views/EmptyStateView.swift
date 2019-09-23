//
//  View.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/22/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        
    }
    
    private func configView() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
