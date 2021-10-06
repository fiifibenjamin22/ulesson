//
//  Subjects+CoreDataProperties.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//
//

import Foundation
import CoreData


extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subjects")
    }

    @NSManaged public var name: String?
    @NSManaged public var ofLessons: Lessons?

}

extension Subjects : Identifiable {

}
