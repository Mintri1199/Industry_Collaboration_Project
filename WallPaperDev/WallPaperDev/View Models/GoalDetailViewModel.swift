//
//  GoalDetailViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/9/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class GoalDetailViewModel {
    var goal: Goal?
    private let coreDataStack = CoreDataStack.shared

    private func updateValidation(_ name: String, _ description: String) -> Bool {
        guard let goalName = goal?.name, let goalDescription = goal?.summary else {
            return false
        }
        return name != goalName || description != goalDescription
    }

    func updateGoal(_ name: String, _ description: String) {
        if let goal = goal, updateValidation(name, description) {
            coreDataStack.updateGoal(goal, name, description)
        }
    }

    func delete() {
        guard let goal = goal else {
            return
        }
        coreDataStack.delete(goal.objectID)
    }
}
