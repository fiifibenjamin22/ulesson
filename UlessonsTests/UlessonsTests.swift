//
//  UlessonsTests.swift
//  UlessonsTests
//
//  Created by Benjamin Acquah on 9/28/21.
//

import XCTest
@testable import Ulessons

class UlessonsTests: XCTestCase {
    
    let kTimeOut = 10.0

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        sleep(1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLiveLessonsFormat() {
        let app = XCUIApplication()
        app.launch()
        
        
    }
    
    func testPromoLessonsFormat() {
        let app = XCUIApplication()
        app.launch()
        
    }
    
    func testMyLessonsFormat() {
        let app = XCUIApplication()
        app.launch()
    }
}
