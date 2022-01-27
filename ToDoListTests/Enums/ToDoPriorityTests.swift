//
//  ToDoPriorityTests.swift
//  ToDoListTests
//
//  Created by Caleb Lindsey on 1/26/22.
//

import XCTest
@testable import ToDoList

class ToDoPriorityTests: XCTestCase {
    func testToDoPriority() throws {
        XCTAssertEqual(ToDoPriority.low.title, "Low")
        XCTAssertEqual(ToDoPriority.medium.title, "Medium")
        XCTAssertEqual(ToDoPriority.high.title, "High")
        
        XCTAssertNotNil(ToDoPriority(0))
        XCTAssertNotNil(ToDoPriority(1))
        XCTAssertNotNil(ToDoPriority(2))
        
        XCTAssertNil(ToDoPriority(3))
        XCTAssertNil(ToDoPriority(4))
        XCTAssertNil(ToDoPriority(5))
    }
}
