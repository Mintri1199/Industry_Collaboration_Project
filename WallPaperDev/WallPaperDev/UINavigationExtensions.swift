//
//  LargeTextEnum.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

// An extension to configuring the font of the nav bar base on length
extension UINavigationBar {
    func configLargeText(length: String) -> [NSAttributedString.Key: Any] {
        return length.count > 12 ?  [NSAttributedString.Key.foregroundColor: UIColor.white,
                                     NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 30) as Any] :
                                    [NSAttributedString.Key.foregroundColor: UIColor.white,
                                     NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 40) as Any]
    }
}

// MARK: - Changing the status when using a navigation controller
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
