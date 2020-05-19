//
//  NSAttributredString+Extension.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/14/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
  static func makeHyperLink(for path: String, in string: String, as substring: String) -> NSMutableAttributedString {
    let nsString = NSString(string: string)
    let substringRange = nsString.range(of: substring)
    let attributedString = NSMutableAttributedString(string: string)
    attributedString.addAttribute(.link, value: path, range: substringRange)
    return attributedString
  }
}
