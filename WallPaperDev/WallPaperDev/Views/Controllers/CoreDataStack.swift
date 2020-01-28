//
//  CoreDataStack.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 9/23/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CoreData
import Foundation

final class CoreDataStack {
  static let shared = CoreDataStack()

  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "GoalPersistence")
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
        })
    return container
  }()

  lazy var context = persistentContainer.viewContext

  // MARK: - Core Data Saving support

  private init() {}

  func saveContext() {
    let context = persistentContainer.viewContext
    print(context)
    if context.hasChanges {
      do {
        try context.save()
        print("saved successfully")
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  // MARK: - Core Data fetch support

  func fetch<T: NSManagedObject>(_ objectType: T.Type, _ filter: String? = nil) -> [T] {
    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

    if let filter = filter {
      let filterPredicate = NSPredicate(format: "name =[c] %@", filter)
      fetchRequest.predicate = filterPredicate
    }
    do {
      let fetchedObjects = try context.fetch(fetchRequest) as? [T]
      return fetchedObjects ?? [T]()
    } catch {
      print(error)
      return [T]()
    }
  }

  func delete(_ object: NSManagedObject) {
    context.delete(object)
    //        saveContext()
  }
}
