//
//  PromoViewModel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

struct PromoViewModel {
    var id: String?
    let tutorFirstName: String?
    let tutorLastName: String?
    let subjectName: String?
    var imageUrl: String?
    var status: String?
    var topic: String?
    var createdAt: String?
    var startAt: String?
    var expiresAt: String?
    
    init(lesson: Lesson) {
        self.id = lesson.id
        self.tutorFirstName = lesson.tutor?.firstname
        self.tutorLastName = lesson.tutor?.lastname
        self.subjectName = lesson.subject?.name
        self.imageUrl = lesson.image_url
        self.status = lesson.status
        self.topic = lesson.topic
        self.createdAt = lesson.createdAt
        self.startAt = lesson.start_at
        self.expiresAt = lesson.expires_at
    }
    
    func getLastName() -> String {
        guard let lname = self.tutorLastName  else { return "" }
        if self.tutorLastName.isEmptyOrNil {
            return ""
        }else{
            return lname
        }
    }
    
    func getDate() -> String {
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
}
