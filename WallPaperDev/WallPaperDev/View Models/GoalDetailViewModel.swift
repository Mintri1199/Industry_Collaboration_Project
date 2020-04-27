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
    milestones = goal.milestonesArray
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

  func addMilestoneToGoal(_ description: String) {
    _ = coreDataStack.createMilestone(description, goal)
    coreDataStack.saveContext()
    /*
     TODO: There could be improvement here
     Rational: everytime goal.milestonesArray is invoke, it sort it by date, whether it is insertion or deletion.
     */
    milestones = goal.milestonesArray
  }

  func deleteMilestone(_ milestone: Milestone, index: Int) {
    coreDataStack.delete(milestone.objectID)
    coreDataStack.saveContext()
    milestones.remove(at: index)
  }

  func updateMilestone(for milestone: Milestone, description: String, completed: Bool=false) {
    coreDataStack.updateMilestone(for: milestone, name: description, completed: completed)
    coreDataStack.saveContext()
  }
}
