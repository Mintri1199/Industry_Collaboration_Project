//
//  Milestone+CoreDataProperties.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 12/9/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Milestone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Milestone> {
        return NSFetchRequest<Milestone>(entityName: "Milestone")
    }

    @NSManaged public var currentNumber: Double
    @NSManaged public var name: String?
    @NSManaged public var totalNumber: Double
    @NSManaged public var goal: Goal?

}
