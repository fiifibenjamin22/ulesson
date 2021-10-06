//
//  PromoListViewModel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation

class PromoListViewModel {
    
    var promoViewModels = [LessonsMainViewModel]()
    var lessonDataManager = LessonDataManager()
    
    var rowsCount: Int {
        return promoViewModels.count
    }
    
    func fetchPromos(completion: @escaping (Bool) -> ()) {
        lessonDataManager.fetchLessons { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
                case .success(let lessons):
                    self.promoViewModels = lessons.map{ LessonsMainViewModel(lesson: $0) }
                    completion(true)
                case .failure(_):
                    completion(false)
            }
        }
    }
}
