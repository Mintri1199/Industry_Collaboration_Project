//
//  GoalDetailViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/9/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class GoalDetailViewModel: ViewModelProtocol {
  var goal: Goal
  var milestones: [Milestone] = []
  private let coreDataStack = CoreDataStack.shared

  init(goal: Goal) {
    self.goal = goal
  }

  private func updateValidation(_ name: String, _ description: String) -> Bool {
    guard let goalName = goal.name, let goalDescription = goal.summary else {
      return false
    }
    return name != goalName || description != goalDescription
  }

  func updateGoal(_ name: String, _ description: String) {
    if updateValidation(name, description) {
      coreDataStack.updateGoal(goal, name, description)
      coreDataStack.saveContext()
    }
  }

  func delete() {
    coreDataStack.delete(goal.objectID)
    coreDataStack.saveContext()
  }
}
