//
//  LessonDestination.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

enum LessonDestination {
    case lesson(lesson: [LessonViewModel])
}

extension LessonDestination: Destination {
    var viewController: UIViewController {
        switch self {
        case .lesson(let lessonModel):
            let viewController = MyLessonsViewVC()
            viewController.lessonViewModel = lessonModel
            return viewController
        }
    }
}
