//
//  Lesson.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

struct LessonResponse: Decodable {
    let success: Bool
    let data: [Lesson]
}

struct Lesson: Decodable {
    let id: String
    let tutor: Tutor
    let subject: Subject
    let image_url: String
    let status: String
    let topic: String
    let createdAt: String
    let start_at: String
    let expires_at: String
}
