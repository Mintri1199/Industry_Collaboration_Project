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
    container.loadPersistentStores { description, error in
      
      if let error = error {
        #if DEBUG
          fatalError("Something Went wrong \(error)")
        #endif
      }
      
      precondition(description.type == NSInMemoryStoreType)
    }
    container.viewContext.name = "Mock"
    return container
  }()
  
  override func setUpWithError() throws {
    manager = CoreDataStack(container: mockPersistentContainer)
    createMockGoals()
  }
  
  override func tearDownWithError() throws {
    clearData()
  }
  
  func testFetchGoals() {
    XCTAssertTrue(itemsTotalCount() == 3)
    XCTAssertTrue(manager.fetchGoals().count == 3)
  }
  
  func testCreateGoal() {
    XCTAssertTrue(itemsTotalCount() == 3, "CreateMockGoals is not working properly")
    let name = "New Goal"
    let summary = "Goal summary"
    
    manager.createGoal(name, summary)
    
    XCTAssertTrue(itemsTotalCount() == 4, "Unable to add new goal")
    
    _ = manager.fetchGoals()
  }
  
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
  
  private func createMockGoals() {
    // TODO: - (jackson) CoreData: warning: Unable to load class named 'KabegamiTests.Goal' for entity 'Goal'.  Class not found, using default NSManagedObject instead.
    func insertGoal(name: String, summary: String) -> Goal? {
      let object = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: manager.context)
      
      object.setValue(name, forKey: "name")
      object.setValue(summary, forKey: "summary")
      
      return object as? Goal
    }
    
    // Create a few goals
    insertGoal(name: "Get Active", summary: "Go to the gym")
    insertGoal(name: "Buy a Car", summary: "Save Money")
    insertGoal(name: "Get a Job", summary: "Apply actively")
    
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
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
    do {
      let objs = try mockPersistentContainer.viewContext.fetch(fetchRequest)
      for case let obj as NSManagedObject in objs {
        mockPersistentContainer.viewContext.delete(obj)
      }
      try mockPersistentContainer.viewContext.save()
    } catch {
      #if DEBUG
        print("Can't clear data: \(error)")
      #endif
    }
  }
  
  private func itemsTotalCount() -> Int {
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
    
    do {
      let results = try mockPersistentContainer.viewContext.fetch(request)
      return results.count
    } catch {
      #if DEBUG
        print("Can't count the fetch result: \(error)")
      #endif
      return 0
    }
  }
}
