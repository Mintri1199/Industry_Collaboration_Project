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
    XCTAssertTrue(goal?.name == name)
    XCTAssertTrue(goal?.summary == summary)
    XCTAssertTrue((goal?.milestonesArray.isEmpty) != nil)
    XCTAssertNotNil(goal?.completedMilestones)
    XCTAssertEqual(goal?.completedMilestones, 0)
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
  
  func testMilestoneCreationToGoal() {
    let name = "NewGoal"
    let summary = "NewSummary"
    let milestoneName = "NewMilestone"
    let newGoal = manager.createGoal(name, summary)
    let milestone = manager.createMilestone(milestoneName, newGoal!)
    let testDate = Date()
    let milestoneDate = milestone?.createdAt
    let milestoneDateString = DateFormatter.localizedString(from: milestoneDate!, dateStyle: .short, timeStyle: .none)
    let testDateString = DateFormatter.localizedString(from: testDate, dateStyle: .short, timeStyle: .none)
    manager.saveContext()
    
    // Check properties of milestone entity
    XCTAssertNotNil(milestone)
    XCTAssertNotNil(milestone?.createdAt)
    XCTAssertNil(milestone?.completedAt)
    XCTAssertNotNil(milestone?.name)
    XCTAssertNotNil(milestone?.completed)
    XCTAssertEqual(milestoneName, milestone?.name!)
    XCTAssertEqual(false, milestone?.completed)
    XCTAssertEqual(milestoneDateString, testDateString)
    XCTAssertNotNil(milestone?.goal)
    XCTAssertEqual(milestone?.goal, newGoal)
    
    // Check milestone related properties in goal entity
    XCTAssertFalse(newGoal!.milestonesArray.isEmpty)
    XCTAssertEqual(newGoal?.milestonesArray.count, 1)
    XCTAssertTrue(newGoal!.milestones!.contains(milestone!))
  }
  
  func testMultipleMilestones() {
    let name = "NewGoal"
    let summary = "NewSummary"
    let newGoal = manager.createGoal(name, summary)!
    let testMilestones = ["new", "milestone", "names"].compactMap { manager.createMilestone($0, newGoal) }
    
    manager.saveContext()
    XCTAssertFalse(newGoal.milestonesArray.isEmpty)
    XCTAssertEqual(newGoal.milestonesArray.count, 3)
    testMilestones.forEach { value in
      XCTAssertTrue(newGoal.milestones!.contains(value))
    }
  }
  
  func testUpdateMilestone() {
    let name = "NewGoal"
    let summary = "NewSummary"
    let goal = manager.createGoal(name, summary)!
    let testMilestones = ["new", "milestone", "names"].compactMap { manager.createMilestone($0, goal) }
    let testMilestone = testMilestones[0]
    
    manager.updateMilestone(for: testMilestone, name: "update", completed: true)
    manager.saveContext()
    
    XCTAssertNotNil(testMilestone.completedAt)
    XCTAssertTrue(testMilestone.completed)
    XCTAssertEqual(testMilestone.name, "update")
    
    let testDate = Date()
    let completeDate = testMilestone.completedAt
    let completeDateString = DateFormatter.localizedString(from: completeDate!, dateStyle: .short, timeStyle: .none)
    let testDateString = DateFormatter.localizedString(from: testDate, dateStyle: .short, timeStyle: .none)
    XCTAssertEqual(completeDateString, testDateString)
    XCTAssertTrue(goal.milestones!.contains(testMilestone))
  }
  
  func testCountCompletedMilestonesFromGoal() {
    let name = "NewGoal"
    let summary = "NewSummary"
    let goal = manager.createGoal(name, summary)!
    _ = ["new", "milestone", "names"].compactMap { manager.createMilestone($0, goal) }
      .compactMap { manager.updateMilestone(for: $0, name: nil, completed: true) }
    manager.saveContext()
    
    XCTAssertEqual(goal.completedMilestones, 3)
  }
  
  func testDeleteMilestoneFromGoal() {
    let name = "NewGoal"
    let summary = "NewSummary"
    let goalToDelete = manager.createGoal(name, summary)!
    var deleteMileStones = ["new", "milestone", "names"].compactMap { manager.createMilestone($0, goalToDelete) }
    let deleteSingleMilestone = deleteMileStones.remove(at: 0)
    manager.saveContext()
    XCTAssertEqual(manager.fetchMilestones().count, 3)
    
    manager.delete(deleteSingleMilestone.objectID)
    manager.saveContext()
    
    XCTAssertEqual(goalToDelete.milestonesArray.count, 2)
    XCTAssertEqual(manager.fetchMilestones().count, 2)
    XCTAssertEqual(goalToDelete.milestonesArray.filter { $0.name == "new" }.count, 0)
    
    manager.delete(goalToDelete.objectID)
    manager.saveContext()
    
    XCTAssertEqual(manager.fetchMilestones().count, 0)
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
