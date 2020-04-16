//
//  Milestone+CoreDataProperties.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/15/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData

extension Milestone {

  @NSManaged public var createdAt: Date
  @NSManaged public var name: String?
  @NSManaged public var completed: Bool
  @NSManaged public var goal: Goal?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<Milestone> {
    return NSFetchRequest<Milestone>(entityName: "Milestone")
  }
}
