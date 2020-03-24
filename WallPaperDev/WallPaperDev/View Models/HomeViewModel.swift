//
//  HomeViewModel.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CoreData
import Foundation

class HomeViewModel: ViewModelProtocol {
  var goalsArr: [Goal] = []
  private let coreDataStack: CoreDataStack = CoreDataStack.shared

  func update(completion: @escaping () -> Void) {
    goalsArr = coreDataStack.fetchGoals()
    completion()
  }
}
