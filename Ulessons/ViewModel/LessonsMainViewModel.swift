//
//  LessonsMainViewModel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation

class LessonsMainViewModel {
    
    var lesson = Lesson()
    var lessonDataManager = LessonDataManager()
    
    var id: String? {
        return lesson.id
    }
    
    var topic: String? {
        return lesson.topic
    }
    
    var firstName: String? {
        return lesson.tutor?.firstname
    }
    
    var lastName: String? {
        return lesson.tutor?.lastname
    }
    
    var tutorFullName: String? {
        var names = [String]()
        
        if let firstName = firstName {
            names.append(firstName)
        }
        
        if let lastName = lastName {
            names.append(lastName)
        }
        return names.joined(separator: " ")
    }
    
    var subjectName: String? {
        return lesson.subject?.name
    }
    
    var status: String? {
        return lesson.status
    }
    
    var createdAt: String? {
        return lesson.createdAt
    }
    
    var date: String? {
        guard let str = self.createdAt else { return "" }
        var strDate = str
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"
        let datee = dateFormatterGet.date(from: strDate)
        strDate =  dateFormatterPrint.string(from: datee ?? Date())
        return "\(strDate)"        
    }
    
    var imageUrl: String? {
        return lesson.image_url
    }
    
    init(lesson: Lesson) {
        self.lesson = lesson
    }
    
    init() {}
}
