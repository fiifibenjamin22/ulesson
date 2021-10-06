//
//  MyLessonsViewModel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation

class MyLessonsListViewModel {
    
    var myLessonsListViewModels = [LessonsMainViewModel]()
    var lessonDataManager = LessonDataManager()
    
    var rowsCount: Int {
        return myLessonsListViewModels.count
    }
    
    func fetchMyLessons(completion: @escaping (Bool) -> ()) {
        lessonDataManager.fetchMyLessons { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
                case .success(let lessons):
                    self.myLessonsListViewModels = lessons.map{ LessonsMainViewModel(lesson: $0) }
                    completion(true)
                case .failure(_):
                    completion(false)
            }
        }
    }
}
