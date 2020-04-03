//
//  NSManagedObject+Extensions.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/2/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import CoreData

extension NSManagedObject {

  class func entityName() -> String {
    let fullClassName = NSStringFromClass(self)
    let classNameComponents: [String] = fullClassName.split(separator: ".").compactMap { String($0) }
    return classNameComponents.last!
  }

  convenience init(context: NSManagedObjectContext) {
    let entityDescription = NSEntityDescription.entity(forEntityName: type(of: self).entityName(), in: context)!
    self.init(entity: entityDescription, insertInto: context)
  }
}
