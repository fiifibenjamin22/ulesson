//
//  LessonViewModel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

struct LessonViewModel {
    var id: String
    var tutor: Tutor
    var subject: Subject
    var imageUrl: String
    var status: String
    var topic: String
    var createdAt: String
    var startAt: String
    var expiresAt: String
    
    init(lesson: Lesson) {
        self.id = lesson.id
        self.tutor = lesson.tutor
        self.subject = lesson.subject
        self.imageUrl = lesson.image_url
        self.status = lesson.status
        self.topic = lesson.topic
        self.createdAt = lesson.createdAt
        self.startAt = lesson.start_at
        self.expiresAt = lesson.expires_at
    }
    
    func getLastName() -> String {
        guard let lname = self.tutor.lastname else { return "" }
        if self.tutor.lastname.isEmptyOrNil {
            return ""
        }else{
            return lname
        }
    }
    
    func getDate() -> String {
        var strDate = self.createdAt
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"
        let datee = dateFormatterGet.date(from: strDate)
        strDate =  dateFormatterPrint.string(from: datee ?? Date())
        return "\(strDate)"
    }
    
    
}
