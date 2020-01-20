//
//  GoalDescriptionTextView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalDescriptionTextView: UITextView {
  let placeHolder = Localized.string("goal_description_placeholder")
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        text = placeHolder
        textColor = .placeholderGray
        autocorrectionType = .no
        font = UIFont(name: "HelveticaNeue", size: 25)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
