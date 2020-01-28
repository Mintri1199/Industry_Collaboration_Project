//
//  EditTextViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 12/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

protocol SaveChange: AnyObject {
    func applyChanges(_ textFrame: CGRect, _ layerRotation: CGFloat)
}

class EditTextViewModel {
    var labelFrame: CGRect?
    var labelRotation: CGFloat?
    weak var delegate: SaveChange?
    var newRotation: CGFloat?
    var labelText: String?

    func updateText(newFrame: CGRect, newRotation: CGFloat) {
        guard let prevFrame = labelFrame, let prevRotation = labelRotation else {
            return
        }

        if prevFrame != newFrame || prevRotation != newRotation {
            delegate?.applyChanges(newFrame, newRotation)
        }
    }
}
