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
  
  let createGoalVC = CreateGoalViewController()
  let createGoalView = CreateGoalView()
  let coreDataStack = CoreDataStack.shared
  
  override func setUpWithError() throws {}
  
  override func tearDownWithError() throws {}
  
  func testCreateGoal() throws {
    let userGoalName = createGoalView.goalNameTextField.text
    let userGoalSummary = createGoalView.goalDescriptionTextView.text
    
    createGoalVC.createTapped()
    
    XCTAssert(!(userGoalName == nil))
    XCTAssert(!(userGoalSummary == nil))
  }
  
  
  func testCoreDataSave() {
    let goalName = "new goal"
    let goalSummary = "goal summary"
    
    coreDataStack.createGoal(goalName, goalSummary)
    
    let goals = coreDataStack.fetchGoals()
    let retGoalName = goals.filter {
      $0.name == goalName
    }
    XCTAssertEqual(goalName, retGoalName[0].name)
  }
  
  func testCoreDataDelete() {
    let goals = coreDataStack.fetchGoals()
    let goalName = "goal name"
    
    let retGoals = goals.filter {
      $0.name == goalName
    }
    coreDataStack.delete(retGoals[0].objectID)
  }
  
  func testCoreDataRetrieve() {
    let goals = coreDataStack.fetchGoals()
    XCTAssert(!goals.isEmpty)
  }
}
