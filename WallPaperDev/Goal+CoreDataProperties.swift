//
//  Goal+CoreDataProperties.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 9/25/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var summary: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var user: User?

}
