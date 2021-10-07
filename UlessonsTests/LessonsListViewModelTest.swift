//
//  LessonsListViewModelTest.swift
//  UlessonsTests
//
//  Created by Benjamin Acquah on 10/6/21.
//

import XCTest
@testable import Ulessons

class LessonsListViewModelTest: XCTestCase {
    
    var viewModel: LessonsMainViewModel!
    fileprivate var mockData = Lesson(id: "1", tutor: Tutor(firstName: "santa", lastName: "clara"), subject: Subject(subject: "English"), image_url: "", status: "live", topic: "Nouns", createdAt: "01-01-2021", start_at: "01-01-2021", expires_at: "01-01-2021")
    
    override func setUp() {
        super.setUp()
        self.viewModel = LessonsMainViewModel(lesson: mockData)
    }
    
    override class func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        let expectation = XCTestExpectation(description: "No service found")
        
    }
}
