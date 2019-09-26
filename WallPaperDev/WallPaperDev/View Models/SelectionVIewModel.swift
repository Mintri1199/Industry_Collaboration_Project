//
//  selectionViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/17/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class SelectionViewModel {
    let imageArray: [UIImage?] = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")]
    
    var selectedGoals: [String] = []
    
    var selectedImage: UIImage?
    
    func validation(button: UIButton) {
        if selectedGoals.isEmpty || selectedImage == nil {
            button.isHidden ?   nil :
                UIView.animate(withDuration: 0.5, animations: {
                    button.isHidden = true
                })
        } else {
            !button.isHidden ?   nil :
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden = false
            })
        }
    }
    
    // MARK: Implement Animations
    private func animateButtonAppearance(_ button: BigBlueButton) {
        let moveUp = CABasicAnimation(keyPath: "position.y")
        moveUp.fromValue = 100
        moveUp.toValue = button.layer.position.y
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0
        fadeIn.toValue = 1
        
        let group = CAAnimationGroup()
        group.animations = [moveUp, fadeIn]
        group.duration = 0.5
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.setValue("moveDown", forKey: "name")
        group.setValue(button, forKey: "button")
        
        button.layer.add(group, forKey: nil)
    }
    
    private func animateButtonDisappearance(_ button: BigBlueButton) {
        let moveDown = CABasicAnimation(keyPath: "position.y")
        moveDown.toValue = 100
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        
        let group = CAAnimationGroup()
        group.animations = [moveDown, fadeOut]
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.setValue("moveDown", forKey: "name")
        group.setValue(button, forKey: "button")
        button.layer.add(group, forKey: nil)
    }
}
