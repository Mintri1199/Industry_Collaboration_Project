//
// Created by Jackson Ho on 5/13/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

struct DevProfile {
  enum Dev: CaseIterable {
    case alex
    case jamar
    case jackson
    case stephen
  }
  
  let name: String
  let githubUrlString: String
  let image: UIImage
  
  init(for dev: Dev) {
    switch dev {
    case .alex:
      self.name = "Alex Dejeu"
      self.githubUrlString = "https://github.com/alexander-dejeu"
      self.image = ApplicationDependency.manager.currentTheme.imageAssets.alexProfile
    case .jamar:
      self.name = "Jamar Gibbs"
      self.githubUrlString = "https://github.com/j-n4m4573"
      self.image = ApplicationDependency.manager.currentTheme.imageAssets.jamarProfile
    case .jackson:
      self.name = "Jackson Ho"
      self.githubUrlString = "https://github.com/Mintri1199"
      self.image = ApplicationDependency.manager.currentTheme.imageAssets.jacksonProfile
    case .stephen:
      self.name = "Stephen Ouyang"
      self.githubUrlString = "https://github.com/Xisouyang"
      self.image = ApplicationDependency.manager.currentTheme.imageAssets.stephenProfile
    }
  }
}

class AboutViewModel {
  let libraryNames = [Localized.string("swiftLint_title"), Localized.string("swiftFormat_title"), Localized.string("cropVC_title")].sorted()
  let devProfiles = DevProfile.Dev.allCases.compactMap{ DevProfile(for: $0) }.sorted { $0.name < $1.name }
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
  
  func contructFeedbackText() -> NSMutableAttributedString {
    let emailPath = "mailto:mintri1199@gmail.com"
    let formPath = "https://forms.gle/2wiZbNmaC7w3UCrK9"
    
    let attributedString = NSMutableAttributedString.makeHyperLink(for: emailPath, in: Localized.string("email_bodytext"), as: "mintri1199@gmail.com")
    let feedbackLink = NSMutableAttributedString.makeHyperLink(for: formPath, in: Localized.string("feedback_text"), as: "feedback form")
    attributedString.insert(feedbackLink, at: attributedString.length)
    let feedBackText = NSAttributedString(string: Localized.string("the_rest_of_feedback"))
    attributedString.insert(feedBackText, at: attributedString.length)
    
    return attributedString
  }
}
