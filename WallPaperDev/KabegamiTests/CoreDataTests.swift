//
//  CoreDataTests.swift
//  KabegamiTests
//
//  Created by Jackson Ho on 3/30/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//
import CoreData

import XCTest

@testable import Kabegami

class CoreDataTests: XCTestCase {
  var manager: CoreDataStack!
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
    return managedObjectModel
  }()
  
  lazy var mockPersistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WallPaperDev", managedObjectModel: self.managedObjectModel)
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false
    
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { (description, error) in
      
      if let error = error {
        #if DEBUG
        fatalError("Something Went wrong \(error)")
        #endif
      }
      
      precondition(description.type == NSInMemoryStoreType)
    }

    return container
  }()
  
  override func setUpWithError() throws {
    createMockItems()
//    manager = CoreDataStack
  }
  
  override func tearDownWithError() throws {}
  
  
  
//  func testCoreDataSave() {
//    let goalName = "new goal"
//    let goalSummary = "goal summary"
//
//    coreDataStack.createGoal(goalName, goalSummary)
//
//    let goals = coreDataStack.fetchGoals()
//    let retGoalName = goals.filter {
//      $0.name == goalName
//    }
//    XCTAssertEqual(goalName, retGoalName[0].name)
//  }
//
//  func testCoreDataDelete() {
//    let goals = coreDataStack.fetchGoals()
//    let goalName = "goal name"
//
//    let retGoals = goals.filter {
//      $0.name == goalName
//    }
//    coreDataStack.delete(retGoals[0].objectID)
//  }
//
//  func testCoreDataRetrieve() {
//    let goals = coreDataStack.fetchGoals()
//    XCTAssert(!goals.isEmpty)
//  }
  
  private func createMockItems() {
    func insertGoal(title: String, description: String) -> Goal? {
      let object = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: mockPersistentContainer.viewContext)
      
      object.setValue(title, forKey: "title")
      object.setValue(description, forKey: "description")
      
      return object as? Goal
    }
    
    // Create a few goals
    insertGoal(title: "Get Active", description: "Go to the gym")
    insertGoal(title: "Buy a Car", description: "Save Money")
    insertGoal(title: "Get a Job", description: "Apply actively")
    
    // Save the context
    do {
      try mockPersistentContainer.viewContext.save()
    } catch {
      #if DEBUG
      print("Unable to create mock goals: \(error)")
      #endif
    }
  }
  
  private func clearData() {
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
    let objs = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
    for case let obj as NSManagedObject in objs {
        mockPersistentContainer.viewContext.delete(obj)
    }
    try! mockPersistentContainer.viewContext.save()
    
  }
  
  private func itemsTotalCount() -> Int {
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
    let results = try! mockPersistentContainer.viewContext.fetch(request)
    return results.count
  }
}
