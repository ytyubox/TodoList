//
//  TodoListAppTests.swift
//  TodoListAppTests
//
//  Created by 游宗諭 on 2019/3/18.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import XCTest
@testable import TodoListApp

class TodoListAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testStringRGBHextoInt(){
    let code = "FF000F".RGB_Htoi
    assert(code.r == 255, "red fail")
    assert(code.g == 0, "green fail")
    assert(code.b == 15, "blue fail")
  }
  func testAppColor() {
    let codes = ["FF4355","FBAA21","0063FF"].map{$0.RGB_Htoi}
    let colors = [UIColor.todoRed,.todoOrange,.todoBlue]

    zip(codes, colors).enumerated().forEach{
      let color = UIColor(r: $1.0.r, g: $1.0.g, b: $1.0.b)
      assert($1.1 == color,  "App red fail"  +  "\($0)\($1)")
    }
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

}
