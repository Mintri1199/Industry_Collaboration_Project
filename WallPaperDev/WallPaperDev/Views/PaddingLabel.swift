//
//  PaddingLabel.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    private var topInset: CGFloat = 5.0
    private var bottomInset: CGFloat = 5.0
    private var leftInset: CGFloat = 14.0
    private var rightInset: CGFloat = 14.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }    
}
