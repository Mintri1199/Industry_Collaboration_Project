//
//  ChooseGoalViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/25/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

final class ChooseGoalViewModel {
  let slectedGoalMaxCount = 4
  var selectedGoals: [Goal] = []
  var goals: [Goal] = []

  private let coreDataStack: CoreDataStack = CoreDataStack.shared

  func populateDataSource() {
    goals = coreDataStack.fetchGoals()
  }

  func preselectGoals(_ array: [Goal]) {
    selectedGoals = array
  }
}
