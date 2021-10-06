//
//  UserEntity+Helper.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation

extension Lessons {
    func toLessonsModel() -> Lesson {
        
        return Lesson(
            id: id,
            tutor: Tutor(firstName: tutorFirstName ?? "", lastName: tutorLastName ?? ""),
            subject: Subject(subject: subjectsName ?? ""),
            image_url: image_url,
            status: status,
            topic: topic,
            createdAt: createdAt,
            start_at: start_at,
            expires_at: expires_at
        )
    }
}
