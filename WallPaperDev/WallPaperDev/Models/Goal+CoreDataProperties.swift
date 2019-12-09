//
//  Goal+CoreDataProperties.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 12/9/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var milestones: NSSet?

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
