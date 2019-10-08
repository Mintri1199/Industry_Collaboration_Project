//
//  CreateGoalVCTests.swift
//  WallPaperDevUITests
//
//  Created by Jamar Gibbs on 9/30/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
import XCTest


@testable import WallPaperDev

class CreateGoalVCTests: XCTestCase {
    
    let createGoalVC = CreateGoalViewController()
    let createGoalView = CreateGoalView()
    let coreDataStack = CoreDataStack.shared
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // ----> Arrange, Act, Assert
    func testCreateGoal() {
    // Arrange
        let userGoalName = createGoalView.goalNameTextField.text
        let userGoalSummary = createGoalView.goalDescriptionTextView.text
    // Act
        createGoalVC.addTapped()

    // Assert
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
        XCTAssert(!(goals.isEmpty))
    }
    
}













