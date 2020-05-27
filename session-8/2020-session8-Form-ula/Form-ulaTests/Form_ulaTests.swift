//
//  Form_ulaTests.swift
//  Form-ulaTests
//
//  Created by T. Andrew Binkowski on 3/5/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import XCTest

@testable import Form_ula

class Form_ulaTests: XCTestCase {

  var vc = FormTableViewController()

//  override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

  func testValidateEmail() {
    XCTAssert(vc.validateEmail("password") == false)
    XCTAssert(vc.validateEmail("test@test.com") == true)
    XCTAssert(vc.validateEmail("test@test2.com") == true)
  }
  
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
