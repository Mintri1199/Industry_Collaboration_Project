//
//  KabegamiTests.swift
//  KabegamiTests
//
//  Created by Jackson Ho on 3/30/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import XCTest

@testable import Kabegami

class KabegamiTests: XCTestCase {
  
  private let themeManager = ApplicationDependency.manager
  
  override func setUpWithError() throws {}
  
  override func tearDownWithError() throws {}
  
  func testThemeColors() {
    
    XCTAssertEqual(themeManager.currentTheme.colors.black, UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.white, UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.navBarBlue, UIColor(red: 0.33, green: 0.71, blue: 0.94, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.sectionBlue, UIColor(red: 0.22, green: 0.65, blue: 0.90, alpha: 1.00))
    
    XCTAssertEqual(themeManager.currentTheme.colors.wallpaperBlue, UIColor(red: 0.57, green: 0.9, blue: 0.96, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.backgroundOffWhite, UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.foregroundWhite, UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.placeholderGray, UIColor(red: 0.84, green: 0.84, blue: 0.85, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.layerBackgroundWhite, UIColor(red: 1, green: 1, blue: 1, alpha: 0.2))
    
    XCTAssertEqual(themeManager.currentTheme.colors.addButtonRed, UIColor(red: 1, green: 0.44, blue: 0.44, alpha: 1))
    
    XCTAssertEqual(themeManager.currentTheme.colors.lightGray, UIColor.lightGray)
    
    XCTAssertEqual(themeManager.currentTheme.colors.darkGray, UIColor.darkGray)
    
    XCTAssertEqual(themeManager.currentTheme.colors.shadow, UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
  }
  
  func testThemeImagesExistence() {
    var bundlePhoto: UIImage?
    bundlePhoto = UIImage(named: "unsplash")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.unsplashLogo, bundlePhoto)
    
    bundlePhoto = UIImage(named: "background_preview_camera")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.backgroundPreviewCamera, bundlePhoto)
    
    bundlePhoto = UIImage(named: "background_preview_flashlight")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.backgroundPreviewFlashlight, bundlePhoto)
    
    bundlePhoto = UIImage(named: "tutorial_example_1")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.tutorialExample1, bundlePhoto)
    
    bundlePhoto = UIImage(named: "tutorial_finger")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.tutorialFinger, bundlePhoto)
    
    bundlePhoto = UIImage(named: "tutorial_goal_text_example")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.tutorialGoalTextExample, bundlePhoto)
    
    bundlePhoto = UIImage(named: "tutorial_phone")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.tutorialPhone, bundlePhoto)
    
    bundlePhoto = UIImage(named: "tutorial_todo_banner")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.tutorialTodoBanner, bundlePhoto)
    
    bundlePhoto = UIImage(named: "tutorial_welcome_banner")
    
    XCTAssertNotNil(bundlePhoto)
    XCTAssertEqual(themeManager.currentTheme.imageAssets.tutorialWelcomeBanner, bundlePhoto)
  }
}
