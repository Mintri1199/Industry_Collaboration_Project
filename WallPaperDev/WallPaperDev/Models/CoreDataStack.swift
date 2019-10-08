//
//  CoreDataStack.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WallPaperDev")
        container.loadPersistentStores(completionHandler: { ( _, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // Why does this need to be here?
    private init() {}
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        print(context)
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data fetch support
//    func fetch<T: NSManagedObject>(_ objectType: T.Type, _ filter: String? = nil) -> [T] {
//
//        let entityName = String(describing: objectType)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//
//        if let filter = filter {
//            let filterPredicate = NSPredicate(format: "name =[c] %@", filter)
//            fetchRequest.predicate = filterPredicate
//        }
//        do {
//            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
//            return fetchedObjects ?? [T]()
//        } catch {
//            print(error)
//            return [T]()
//        }
//    }
    
    func fetchGoals() -> [Goal] {
        var goalNameArr: [Goal] = []
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
            do {
                goalNameArr = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
//        let goals: [Goal] = goalNameArr as? [Goal] ?? []
        return goalNameArr
    }
    
    func fetchOneGoal(_ objectID: NSManagedObjectID) {
    }
    
    func delete(_ objectID: NSManagedObjectID) {
        let object = context.object(with: objectID)
        context.delete(object)
        //        saveContext()
    }
    
    func createGoal(_ name: String, _ summary: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Goal", in: context)
        guard let unwrappedEntity = entity else {
            print("failure obtaining entity")
            return
        }
        
//        let goal = NSManagedObject(entity: unwrappedEntity, insertInto: context)
//        goal.setValue(name, forKey: "name")
//        goal.setValue(summary, forKey: "summary")
        let goal = Goal(entity: unwrappedEntity, insertInto: context)
        goal.name = name
        goal.summary = summary
        saveContext()
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
            print(error.localizedDescription)
        }
    }
}
