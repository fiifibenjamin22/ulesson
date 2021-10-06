//
//  LessonsListViewModel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation

class LessonsListViewModel {
    
    var lessonsViewModels = [LessonsMainViewModel]()
    var lessonDataManager = LessonDataManager()
    
    var rowsCount: Int {
        return lessonsViewModels.count
    }
    
    func fetchLessons(completion: @escaping (Bool) -> ()) {
        lessonDataManager.fetchLessons { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
                case .success(let lessons):
                    self.lessonsViewModels = lessons.map{ LessonsMainViewModel(lesson: $0) }
                    completion(true)
                case .failure(_):
                    completion(false)
            }
        }
    }
}
