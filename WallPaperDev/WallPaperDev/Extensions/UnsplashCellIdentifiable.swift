//
//  UnsplashCellIdentifiable.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 3/19/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol UnsplashIdentifiable {
  var urlString: String { get }
}

@available(iOS 13.0, *)
extension UnsplashIdentifiable {
  var pictureId: NSString {
    NSString(string: urlString)
  }

  func isReferenced(by configuration: UIContextMenuConfiguration) -> Bool {
    return pictureId == configuration.identifier as? NSString
  }
}

@available(iOS 13.0, *)
extension Array where Element: UnsplashIdentifiable {

  func item(for configuration: UIContextMenuConfiguration) -> Element? {
    return first(where: { $0.pictureId == configuration.identifier as? NSString })
  }

  func index(for configuration: UIContextMenuConfiguration) -> Index? {
    return firstIndex(where: { $0.pictureId == configuration.identifier as? NSString })
  }
}
