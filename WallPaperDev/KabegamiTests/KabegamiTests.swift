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
  
  func testImagesExistence() {
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
