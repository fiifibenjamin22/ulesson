//
//  LessonsListViewModelTest.swift
//  UlessonsTests
//
//  Created by Benjamin Acquah on 10/6/21.
//

import XCTest
@testable import Ulessons

class LessonsListViewModelTest: XCTestCase {
    
    var lessonDataManager = LessonDataManager()
    let lessonsServiceManager = Service()
    let lessonDBManager = LessonsDBManager()
    
    var viewModel: LessonsMainViewModel!
    fileprivate var mockData = Lesson(id: "1", tutor: Tutor(firstName: "santa", lastName: "clara"), subject: Subject(subject: "English"), image_url: "", status: "live", topic: "Nouns", createdAt: "01-01-2021", start_at: "01-01-2021", expires_at: "01-01-2021")
    
    override func setUp() {
        super.setUp()
        self.viewModel = LessonsMainViewModel(lesson: mockData)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        let expectation = XCTestExpectation(description: "No service found")
        let result = lessonDBManager.fetchAllLessons()
        switch result {
            case .success(let lessons):
                if !lessons.isEmpty {
                    expectation.fulfill()
                }
                //completion(.success(lessons.map{ $0.toLessonsModel()}))
            case .failure(let error):
            print(error.localizedDescription)
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testWithService() {
        let expectation = XCTestExpectation(description: "Service available")
        lessonsServiceManager.fetchAllLessons { [weak self] (result) in
            switch result {
                case .success(let lessons):
                let results = self?.lessonDBManager.save(lessons: lessons) ?? []
                if !results.isEmpty {
                    expectation.fulfill()
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
