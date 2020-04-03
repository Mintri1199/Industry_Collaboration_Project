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
  
  // I think the problem might be here
  lazy var managedObjectModel: NSManagedObjectModel = {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
    return managedObjectModel
  }()
  
  lazy var mockPersistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "WallPaperDev", managedObjectModel: self.managedObjectModel)
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false // Make it simpler in test env
    
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { description, error in
      // Check if the data store is in memory
      precondition( description.type == NSInMemoryStoreType )
      
      // Check if creating container wrong
      if let error = error {
        fatalError("Create an in-mem coordinator failed \(error)")
      }
    }
    return container
  }()
  
  override func setUp() {
    super.setUp()
    initGoalStubs()
    manager = CoreDataStack(container: mockPersistentContainer)
  }
  
  override func tearDown() {
    do {
      try flushData()
    } catch {
      print(error)
    }
    super.tearDown()
  }
  
  func testCreateGoal() {
    let name = "NewGoal"
    let summary = "New summary"
    let goal = manager.createGoal(name, summary)
    XCTAssertNotNil(goal)
  }
  
  func testFetchGoals() {
    XCTAssertTrue(itemsTotalCount() == 3)
    XCTAssertTrue(manager.fetchGoals().count == 3)
  }
  
  func testSave() {
    let name = "NewGoal"
    let summary = "NewSummary"
    
    _ = manager.createGoal(name, summary)
    manager.saveContext()
    
    let goals = manager.fetchGoals()
    XCTAssertEqual(goals.count, 4)
    
    let filteredList = goals.filter { $0.name == name && $0.summary == summary }
    XCTAssertFalse(filteredList.isEmpty)
  }
  
  func testCoreDataDelete() {
    let goals = manager.fetchGoals()
    let goalToDelete = goals[0]
    let goalName = goalToDelete.name
    
    manager.delete(goalToDelete.objectID)
    manager.saveContext()
    XCTAssertTrue(itemsTotalCount() == 2)
    let newGoalsList = manager.fetchGoals()
    for goal in newGoalsList {
      XCTAssertFalse(goal.name == goalName)
    }
  }
}

// MARK: - Helper Functions
extension CoreDataTests {
  
  private func initGoalStubs() {
    
    func insertGoal( name: String, summary: String ) -> Goal? {
      let obj = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: mockPersistentContainer.viewContext)
      
      obj.setValue(name, forKey: "name")
      obj.setValue(summary, forKey: "summary")
      
      return obj as? Goal
    }
    // Create a few goals
    _ = insertGoal(name: "Get Active", summary: "Go to the gym")
    _ = insertGoal(name: "Buy a Car", summary: "Save Money")
    _ = insertGoal(name: "Get a Job", summary: "Apply actively")
    
    do {
      try mockPersistentContainer.viewContext.save()
    } catch {
      print("create fakes error \(error)")
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
  
  private func flushData() throws {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
    let objs = try mockPersistentContainer.viewContext.fetch(fetchRequest)
    for case let obj as NSManagedObject in objs {
      mockPersistentContainer.viewContext.delete(obj)
    }
    try mockPersistentContainer.viewContext.save()
  }
}
