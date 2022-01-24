//
//  ToDoItemTests.swift
//  ToDoListTests
//
//  Created by Caleb Lindsey on 1/21/22.
//

import XCTest
@testable import ToDoList

class ToDoItemTests: XCTestCase {
    func testToDoState() {
        XCTAssertEqual(ToDoState.notStarted.toString(), "Not Started")
        XCTAssertEqual(ToDoState.inProgress.toString(), "In Progress")
        XCTAssertEqual(ToDoState.done.toString(), "Done")
    }
    
    func testToDoPriority() throws {
        XCTAssertEqual(Priority.low.title, "Low")
        XCTAssertEqual(Priority.medium.title, "Medium")
        XCTAssertEqual(Priority.high.title, "High")
        
        XCTAssertNotNil(Priority(0))
        XCTAssertNotNil(Priority(1))
        XCTAssertNotNil(Priority(2))
        
        XCTAssertNil(Priority(3))
        XCTAssertNil(Priority(4))
        XCTAssertNil(Priority(5))
    }
}
