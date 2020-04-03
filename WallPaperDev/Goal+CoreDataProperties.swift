//
//  Goal+CoreDataProperties.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import CoreData
import Foundation

extension Goal {
  @NSManaged public var name: String?
  @NSManaged public var summary: String?

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
    NSFetchRequest<Goal>(entityName: "Goal")
  }
}
