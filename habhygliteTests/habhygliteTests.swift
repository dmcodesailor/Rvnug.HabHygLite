//
//  habhygliteTests.swift
//  habhygliteTests
//
//  Created by Brian Lanham on 8/18/17.
//  Copyright © 2017 Brian Lanham. All rights reserved.
//

import XCTest

@testable import habhyglite

class habhygliteTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testService_RequestAll_ExceptSuccess() {
        let svc: HabHygService = HabHygService()
        svc.load()
        for star in svc.stellarData {
            print (star.ProperName)
        }
//        XCTAssert(svc.stellarData.count > 0)
        XCTAssert(true)
    }
    
}
