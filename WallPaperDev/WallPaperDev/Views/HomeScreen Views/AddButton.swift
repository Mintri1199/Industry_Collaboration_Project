//
//  AddButton.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/23/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class AddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        configButton()
    }
    
    private func configButton() {
        self.setTitle("Add", for: .normal)
        self.backgroundColor = .addButtonRed
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.darkGray, for: .highlighted)
        self.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
