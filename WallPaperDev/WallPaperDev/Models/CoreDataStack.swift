//
//  CoreDataStack.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CoreData
import UIKit

private let productionContainer: NSPersistentContainer = {
  let container = NSPersistentContainer(name: "WallPaperDev")
  container.loadPersistentStores(completionHandler: { _, error in
    if let error = error as NSError? {
      fatalError("Unresolved error \(error), \(error.userInfo)")
    }
    })
  return container
}()

final class CoreDataStack {
  
  private let persistentContainer: NSPersistentContainer!
  
  private lazy var backgroundContext: NSManagedObjectContext = {
    return self.persistentContainer.newBackgroundContext()
  }()
  
  static let shared = CoreDataStack()
  
  lazy var context = persistentContainer.viewContext
  
  init(container: NSPersistentContainer) {
    self.persistentContainer = container
  }
  
  convenience init() {
    self.init(container: productionContainer)
  }
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func fetchGoals() -> [Goal] {
    var goalNameArr: [Goal] = []
    let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
    do {
      goalNameArr = try context.fetch(fetchRequest)
    } catch let error as NSError {
      #if DEBUG
        print("Could not fetch. \(error), \(error.userInfo)")
      #endif
    }
    return goalNameArr
  }
  
  func delete(_ objectID: NSManagedObjectID) {
    let object = context.object(with: objectID)
    context.delete(object)
    saveContext()
  }
  
  func createGoal(_ name: String, _ summary: String) {
    if let entity = NSEntityDescription.entity(forEntityName: "Goal", in: context) {
      let goal = Goal(entity: entity, insertInto: context)
      goal.name = name
      goal.summary = summary
      saveContext()
    } else {
      #if DEBUG
        print("Can't create goal")
      #endif
    }
  }
  
  func updateGoal(_ goal: Goal, _ name: String, _ summary: String) {
    goal.name = name
    goal.summary = summary
    saveContext()
  }
  
  func clearCoreData() {
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do {
      try context.execute(deleteRequest)
      try context.save()
    } catch {
      #if DEBUG
        print(error.localizedDescription)
      #endif
    }
  }
}
