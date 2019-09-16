//
//  LargeTextEnum.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

enum LargeTextLength {
    case short  // 5 - 12 characters
    case long   // > 12 characters
}

// An extension to configuring the font of the nav bar base on length
extension UINavigationBar {
    func configLargeText(length: LargeTextLength) -> [NSAttributedString.Key: Any] {
        
        switch length {
        case .short:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 40) as Any]
        case .long:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 30) as Any]
        }
    }
}

// MARK: - Changing the status when using a navigation controller
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
