//
//  Lessons+CoreDataProperties.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//
//

import Foundation
import CoreData


extension Lessons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lessons> {
        return NSFetchRequest<Lessons>(entityName: "Lessons")
    }

    @NSManaged public var id: String?
    @NSManaged public var image_url: String?
    @NSManaged public var status: String?
    @NSManaged public var topic: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var start_at: String?
    @NSManaged public var expires_at: String?
    @NSManaged public var subjectsName: String?
    @NSManaged public var tutorFirstName: String?
    @NSManaged public var tutorLastName: String?
}

extension Lessons : Identifiable {

}
