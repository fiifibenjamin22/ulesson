//
//  Service.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

class Service: NSObject {
    
    static let shared = Service()
    let baseUrl = "https://mock-live-lessons.herokuapp.com/api/v1"
    
    func fetchPromotion(completion: @escaping([Lesson]?, Error?) -> ()) {
        guard let url = URL(string: baseUrl + "/promoted") else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            guard let data = data else { return }
            do {
                let lessons = try JSONDecoder().decode(LessonResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(lessons.data, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
    
    func fetchLessons(completion: @escaping([Lesson]?, Error?) -> ()) {
        guard let url = URL(string: baseUrl + "/lessons") else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            guard let data = data else { return }
            do {
                let lessons = try JSONDecoder().decode(LessonResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(lessons.data, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
}
