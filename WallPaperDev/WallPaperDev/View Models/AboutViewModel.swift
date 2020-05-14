//
// Created by Jackson Ho on 5/13/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

class AboutViewModel {
  let libraryNames = [Localized.string("swiftLint_title"), Localized.string("swiftFormat_title"), Localized.string("cropVC_title")].sorted()
  var licenseItems = [AboutViewController.ItemType]()

  func getLicenseMaterials() -> Zip2Sequence<[String], [String]> {
    let path = Bundle.main.resourcePath!
    let licenseFileURLS = libraryNames.map { path + "/\($0)License.txt" }
    let filesText = licenseFileURLS.compactMap { (filePath) -> String? in
      do {
        let string = try String(contentsOfFile: filePath, encoding: .utf8)
        return string
      } catch {
        return nil
      }
    }

    return zip(libraryNames, filesText)
  }
}
