//
//  LargeTextEnum.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func configLargeText(length: String) -> [NSAttributedString.Key: Any] {
        return length.count > 12 ?  [NSAttributedString.Key.foregroundColor: UIColor.white,
                                     NSAttributedString.Key.font: ApplicationDependency.manager.currentTheme.fontSchema.black32 as Any] :
                                    [NSAttributedString.Key.foregroundColor: UIColor.white,
                                     NSAttributedString.Key.font: ApplicationDependency.manager.currentTheme.fontSchema.black40 as Any]
    }
    
    func configGenericNavBar(text: String) {
        let attributes = text.count > 12 ? [NSAttributedString.Key.foregroundColor: UIColor.white,
                                            NSAttributedString.Key.font: ApplicationDependency.manager.currentTheme.fontSchema.black32 as Any] :
                                           [NSAttributedString.Key.foregroundColor: UIColor.white,
                                            NSAttributedString.Key.font: ApplicationDependency.manager.currentTheme.fontSchema.black40 as Any]
        if #available(iOS 13, *) {
            backgroundColor = ApplicationDependency.manager.currentTheme.colors.navBarBlue
            largeTitleTextAttributes = attributes
        } else {
            barTintColor = ApplicationDependency.manager.currentTheme.colors.navBarBlue
            tintColor = .white
            largeTitleTextAttributes = attributes
        }
    }
}

// MARK: - Changing the status when using a navigation controller
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
