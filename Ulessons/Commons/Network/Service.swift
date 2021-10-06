//
//  Service.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

enum AppURL: String {
    case baseURL = "https://mock-live-lessons.herokuapp.com/api/v1"
    case promo = "/promoted"
    case lessons = "/lessons"
    case myLessons = "/lessons/me"
}

class Service: NSObject {
    
    static let shared = Service()
    
    func fetchAllPromos(completion: @escaping (Result<[Lesson], Error>) -> ()) {
        
        let promoServiceRequest = ServiceHandler<LessonResponse>()
        promoServiceRequest.request(url: AppURL.promo.rawValue, method: .get) { (result) in
            switch result {
                case .success(let decodedObject):
                    completion(.success(decodedObject.data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchAllLessons(completion: @escaping (Result<[Lesson], Error>) -> ()) {
        
        let lessonServiceRequest = ServiceHandler<LessonResponse>()
        lessonServiceRequest.request(url: AppURL.lessons.rawValue, method: .get) { (result) in
            switch result {
                case .success(let decodedObject):
                    completion(.success(decodedObject.data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

    func fetchMyLessons(completion: @escaping (Result<[Lesson], Error>) -> ()) {
        
        let lessonServiceRequest = ServiceHandler<LessonResponse>()
        lessonServiceRequest.request(url: AppURL.myLessons.rawValue, method: .get) { (result) in
            switch result {
                case .success(let decodedObject):
                    completion(.success(decodedObject.data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: String, Error {
    case invalidURL = "URL is not Valid"
    case unknown = "unkowne"
    case sessionExpire = "The Session has Expired"
    case internalServerError = "Looks like server is not working"
    case decodingError = "Something is wrong with codable object"
}

class ServiceHandler<T: Codable> {
    
    func request(url: String,
                 method: HTTPMethod,
                 completionHandler completion: @escaping (Result<T, NetworkError>) -> ()) {
        
        let finalPath = AppURL.baseURL.rawValue +  url
        guard let finalURL = URL(string: finalPath) else {
            completion(.failure(.invalidURL))
            return
        }
        print(finalURL)
        CommonClass.showLoader()
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
        
            DispatchQueue.main.async {
                CommonClass.hideLoader()
                guard let httpResponse = response as? HTTPURLResponse,
                    let responseData = data else {
                        completion(.failure(.unknown))
                        return
                }
                
                let statusCode = httpResponse.statusCode
                if (200...204).contains(statusCode) {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decodedObject = try jsonDecoder.decode(T.self, from: responseData)
                        completion(.success(decodedObject))
                    } catch let error {
                        print(error.localizedDescription)
                        completion(.failure(.decodingError))
                    }
                } else if statusCode == 500 {
                    print("Something went wrong with server")
                    completion(.failure(.internalServerError))
                } else if statusCode == 401 {
                    print("Session expire")
                    completion(.failure(.sessionExpire))
                } else {
                    print(error?.localizedDescription ?? "")
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

 
