//
//  CoreDataStack.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CoreData
import UIKit

final class CoreDataStack {
  
  private lazy var backgroundContext: NSManagedObjectContext = {
    return self.persistentContainer.newBackgroundContext()
  }()
  
  private let persistentContainer: NSPersistentContainer
  
  static let shared = CoreDataStack()
  
  init(container: NSPersistentContainer) {
    self.persistentContainer = container
    self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  convenience init() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("Can not get shared app delegate")
    }
    self.init(container: appDelegate.productionContainer)
  }
  
  // MARK: - Core Data Saving support
  func saveContext() {
    let context = backgroundContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  // MARK: - Core Data fetch support
  func fetchGoals() -> [Goal] {
    let request: NSFetchRequest<Goal> = Goal.fetchRequest()
    let results = try? persistentContainer.viewContext.fetch(request)
    return results ?? [Goal]()
  }
  
  func fetchMilestones() -> [Milestone] {
    let request: NSFetchRequest<Milestone> = Milestone.fetchRequest()
    let results = try? persistentContainer.viewContext.fetch(request)
    return results ?? [Milestone]()
  }
  
  func delete(_ objectID: NSManagedObjectID) {
    let object = backgroundContext.object(with: objectID)
    backgroundContext.delete(object)
    saveContext()
  }
  
  func createGoal(_ name: String, _ summary: String) -> Goal? {
    guard let entity = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: backgroundContext) as? Goal else {
      return nil
    }
    entity.name = name
    entity.summary = summary
    
    return entity
  }
  
  func updateGoal(_ goal: Goal, _ name: String, _ summary: String) {
    goal.name = name
    goal.summary = summary
  }
  
  func createMilestone(_ name: String, _ goalID: NSManagedObjectID) -> Milestone? {
    guard let entity = NSEntityDescription.insertNewObject(forEntityName: "Milestone", into: backgroundContext) as? Milestone, let goal = backgroundContext.object(with: goalID) as? Goal else {
      return nil
    }
    
    entity.name = name
    entity.completed = false
    entity.createdAt = Date()
    entity.completedAt = nil
    goal.addToMilestones(entity)
    return entity
  }
  
  func updateMilestone(for milestone: Milestone, name: String?, completed: Bool) {
    if let newName = name {
      milestone.name = newName
    }
    
    if completed {
      milestone.completed = completed
      milestone.completedAt = Date()
    } else {
      milestone.completed = completed
      milestone.completedAt = nil
    }
  }
  
  func clearCoreData() {
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do {
      try persistentContainer.viewContext.execute(deleteRequest)
      try persistentContainer.viewContext.save()
    } catch {
      #if DEBUG
        print(error.localizedDescription)
      #endif
    }
  }
}
