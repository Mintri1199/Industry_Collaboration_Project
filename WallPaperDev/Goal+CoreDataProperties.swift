//
//  Goal+CoreDataProperties.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/15/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData

extension Goal {
  
  @NSManaged public var name: String?
  @NSManaged public var summary: String?
  @NSManaged public var milestones: NSSet?
  
  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<Goal> {
    return NSFetchRequest<Goal>(entityName: "Goal")
  }
}

// MARK: Generated accessors for milestones
extension Goal {
  
  @objc(addMilestonesObject:)
  @NSManaged public func addToMilestones(_ value: Milestone)
  
  @objc(removeMilestonesObject:)
  @NSManaged public func removeFromMilestones(_ value: Milestone)
  
  @objc(addMilestones:)
  @NSManaged public func addToMilestones(_ values: NSSet)
  
  @objc(removeMilestones:)
  @NSManaged public func removeFromMilestones(_ values: NSSet)
}
