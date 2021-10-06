//
//  LessonDataManager.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation

/*
This class provide user's data either from server or local.
*/
class LessonDataManager {

    let lessonsServiceManager = Service()
    let lessonDBManager = LessonsDBManager()
    
    func fetchPromos(completion: @escaping (Result<[Lesson], Error>) -> ()) {
        
        if Reachability().isOnline {
            
            lessonsServiceManager.fetchAllPromos { [weak self] (result) in
                switch result {
                    case .success(let lessons):
                    let results = self?.lessonDBManager.save(lessons: lessons) ?? []
                        completion(.success(results))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        } else {
            let result = lessonDBManager.fetchAllLessons()
            switch result {
                case .success(let users):
                    completion(.success(users.map{ $0.toLessonsModel()}))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchLessons(completion: @escaping (Result<[Lesson], Error>) -> ()) {
        
        if Reachability().isOnline {
            
            lessonsServiceManager.fetchAllLessons { [weak self] (result) in
                switch result {
                    case .success(let lessons):
                    let results = self?.lessonDBManager.save(lessons: lessons) ?? []
                        completion(.success(results))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        } else {
            let result = lessonDBManager.fetchAllLessons()
            switch result {
                case .success(let users):
                    completion(.success(users.map{ $0.toLessonsModel()}))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchMyLessons(completion: @escaping (Result<[Lesson], Error>) -> ()) {
        
        if Reachability().isOnline {
            
            lessonsServiceManager.fetchMyLessons { [weak self] (result) in
                switch result {
                    case .success(let lessons):
                    let results = self?.lessonDBManager.save(lessons: lessons) ?? []
                        completion(.success(results))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        } else {
            let result = lessonDBManager.fetchAllLessons()
            switch result {
                case .success(let users):
                    completion(.success(users.map{ $0.toLessonsModel()}))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
