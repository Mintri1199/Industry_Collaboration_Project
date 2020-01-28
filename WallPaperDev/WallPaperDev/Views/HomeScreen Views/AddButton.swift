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
        setTitle("Add", for: .normal)
        backgroundColor = .addButtonRed
        setTitleColor(.white, for: .normal)
        setTitleColor(.darkGray, for: .highlighted)
        titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)

        layer.cornerRadius = bounds.width / 2
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
