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
// ----> Arrange, Act, Assert
    func testCreateGoal() {
    // Arrange
        let createGoalVC = CreateGoalViewController()
        let createGoalView = CreateGoalView()
        
        let userGoalName = createGoalView.goalNameTextField.text
        let userGoalSummary = createGoalView.goalDescriptionTextView.text
        
    // Act
        createGoalVC.addTapped()

    // Assert
        XCTAssert(!(userGoalName == nil))
        XCTAssert(!(userGoalSummary == nil))
    }
    
    func testArrangeActAssert() {
        // Arrange --> Given
        let x = 20
        let y = 40
        let expected = 60

        // Act --> When
        let actual = x + y

        // Assert --> Then
        XCTAssertEqual(expected, actual)
    }
}













