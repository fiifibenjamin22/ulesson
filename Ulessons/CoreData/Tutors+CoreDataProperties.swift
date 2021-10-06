//
//  Tutors+CoreDataProperties.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//
//

import Foundation
import CoreData


extension Tutors {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tutors> {
        return NSFetchRequest<Tutors>(entityName: "Tutors")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var ofLessons: Lessons?

}

extension Tutors : Identifiable {

}
