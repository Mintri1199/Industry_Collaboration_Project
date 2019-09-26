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
    
    private init() {}
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WallPaperDev")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
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
    
    
    
    
    
    func delete(_ object: NSManagedObject) {
        
        context.delete(object)
        //        saveContext()
    }

}
