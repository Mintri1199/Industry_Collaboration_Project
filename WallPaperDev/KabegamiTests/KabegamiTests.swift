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
  
  func testLocalizedString() {
    let date = Date()
    let dateString = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
    XCTAssertEqual(Localized.string("goals"), "Goals")
    XCTAssertEqual(Localized.string("goal_details_title"), "Goal Details")
    XCTAssertEqual(Localized.string("good_morning_title"), "Good Morning")
    XCTAssertEqual(Localized.string("good_afternoon_title"), "Good Afternoon")
    XCTAssertEqual(Localized.string("good_evening_title"), "Good Evening")
    XCTAssertEqual(String(format: Localized.string("current_date_time_title"), dateString),
                   String(format: "It is %@", dateString))
    XCTAssertEqual(Localized.string("set_goal_today_prompt"), "Set a goal today!")
    XCTAssertEqual(Localized.string("create_goal_title"), "Create Goal")
    XCTAssertEqual(Localized.string("invalid"), "Invalid")
    XCTAssertEqual(Localized.string("create_goal_error_message"),
                   "You can't create a goal without a name and description")
    XCTAssertEqual(Localized.string("choose_image_title"), "Choose Image")
    XCTAssertEqual(Localized.string("alert_ok"), "OK")
    XCTAssertEqual(Localized.string("change_goals_action"), "Change Goals")
    XCTAssertEqual(Localized.string("choose_goal_action"), "Choose Goal")
    XCTAssertEqual(Localized.string("create_wallpaper_title"), "Create Wallpaper")
    XCTAssertEqual(Localized.string("crop_action"), "Crop")
    XCTAssertEqual(Localized.string("save_image_action"), "Save Image")
    XCTAssertEqual(Localized.string("preview_title"), "Preview")
    XCTAssertEqual(Localized.string("save_wallpaper_error_title"), "Save error")
    XCTAssertEqual(Localized.string("save_wallpaper_success_title"), "Saved!")
    XCTAssertEqual(Localized.string("save_wallpaper_success_message"),
                   "Your altered image has been saved to your photos.")
    XCTAssertEqual(Localized.string("create_action"), "Create")
    XCTAssertEqual(Localized.string("update_action"), "Update")
    XCTAssertEqual(Localized.string("ok_action"), "Ok")
    XCTAssertEqual(Localized.string("edit_action"), "Edit")
    XCTAssertEqual(Localized.string("done_action"), "Done")
    XCTAssertEqual(Localized.string("back_action"), "Back")
    XCTAssertEqual(Localized.string("next_action"), "Next")
    XCTAssertEqual(Localized.string("skip_action"), "Skip")
    XCTAssertEqual(Localized.string("start_action"), "Start")
    XCTAssertEqual(Localized.string("add_action"), "Add")
    XCTAssertEqual(Localized.string("previous_action"), "Previous")
    
    XCTAssertEqual(String(format: Localized.string("choose_goal_title"), String(1), String(4)), "Choose Goal 1 / 4")
    XCTAssertEqual(Localized.string("message_for_goal_with_no_description"), "There is no description for this goal")
    XCTAssertEqual(Localized.string("view_action"), "View")
    XCTAssertEqual(Localized.string("tutorial_title_1"), "Welcome to Kabegami")
    XCTAssertEqual(Localized.string("tutorial_title_2"), "Write it Down")
    XCTAssertEqual(Localized.string("tutorial_message_1"),
                   "We help you keep organize and keep track of your goals\n")
    XCTAssertEqual(Localized.string("tutorial_message_2"),
                   "Start your goal by writing them down. Update your progress anytime")
    XCTAssertEqual(Localized.string("tutorial_demo_title"), "Be Creative")
    XCTAssertEqual(Localized.string("tutorial_demo_message"),
                   "Create a beautiful wallpaper with your goals in it")
    XCTAssertEqual(Localized.string("tutorial_showcase_title"), "Remind Yourself")
    XCTAssertEqual(Localized.string("tutorial_showcase_message"),
                   "See your goals in the lock screen with the picture you’ve created")
    XCTAssertEqual(Localized.string("selected_goal_empty_view_title"),
                   "You didn't select a goal")
    XCTAssertEqual(Localized.string("selected_goal_empty_view_button_cta"), "Tap here to choose goals")
    XCTAssertEqual(Localized.string("goal_title_placeholder"), "Climbing Mount Everest")
    XCTAssertEqual(Localized.string("goal_description_placeholder"),
                   "Train six days a week with one day completely dedicated to rest.")
    XCTAssertEqual(Localized.string("goal_name_title"), "Goal Name")
    XCTAssertEqual(Localized.string("goal_description_title"), "Goal Description")
    XCTAssertEqual(Localized.string("unsplash_searchbar_placeholder"), "Search for images")
  }
  
  func testThemeFonts() {
    var controlFont: UIFont?
    
    controlFont = UIFont(name: "Avenir-Medium", size: 16)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.medium16, controlFont)
    
    controlFont = UIFont(name: "Avenir-Medium", size: 20)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.medium20, controlFont)
    
    controlFont = UIFont(name: "Avenir-Medium", size: 24)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.medium24, controlFont)
    
    controlFont = UIFont(name: "Avenir-Heavy", size: 20)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.heavy20, controlFont)
    
    controlFont = UIFont(name: "Avenir-Heavy", size: 24)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.heavy24, controlFont)
    
    controlFont = UIFont(name: "Avenir-Black", size: 32)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.black32, controlFont)
    
    controlFont = UIFont(name: "Avenir-Black", size: 40)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.black40, controlFont)
    
    controlFont = UIFont(name: "Avenir-Heavy", size: 24)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.titleRegular, controlFont)
    
    controlFont = UIFont.systemFont(ofSize: 20, weight: .light)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.light20, controlFont)
    
    controlFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    XCTAssertEqual(themeManager.currentTheme.fontSchema.regular20, controlFont)
  }
  
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
