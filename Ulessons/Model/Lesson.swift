//
//  Lesson.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit
import CoreData

struct LessonResponse: Codable {
    let success: Bool
    let data: [Lesson]
}

struct Lesson: Codable {
    let id: String?
    let tutor: Tutor?
    let subject: Subject?
    let image_url: String?
    let status: String?
    let topic: String?
    let createdAt: String?
    let start_at: String?
    let expires_at: String?
}

extension Lesson {
    
    init() {
        id = nil
        tutor = nil
        subject = nil
        image_url = nil
        status = nil
        topic = nil
        createdAt = nil
        start_at = nil
        expires_at = nil
    }
    
    func toEntity(onContext context: NSManagedObjectContext? = nil) -> Lessons {
        let context = context ?? Constants.appDelegate.mainContext
        let lessonEntity = Lessons(context: context)
        lessonEntity.id = id
        lessonEntity.tutorFirstName = tutor?.firstname
        lessonEntity.tutorLastName = tutor?.lastname
        lessonEntity.subjectsName = subject?.name
        lessonEntity.image_url = image_url
        lessonEntity.status = status
        lessonEntity.topic = topic
        lessonEntity.createdAt = createdAt
        lessonEntity.start_at = start_at
        lessonEntity.expires_at = expires_at
        return lessonEntity
    }
}
