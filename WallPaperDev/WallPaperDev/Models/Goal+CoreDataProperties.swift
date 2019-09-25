//
//  Goal+CoreDataProperties.swift
//  
//
//  Created by Jamar Gibbs on 9/25/19.
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
    @NSManaged public var name: String?
    @NSManaged public var user: User?

}
