//
//  ToDoItemTests.swift
//  ToDoStateTests
//
//  Created by Caleb Lindsey on 1/21/22.
//

import XCTest
@testable import ToDoList

class ToDoStateTests: XCTestCase {
    func testToDoState() {
        XCTAssertEqual(ToDoState.notStarted.toString(), "Not Started")
        XCTAssertEqual(ToDoState.inProgress.toString(), "In Progress")
        XCTAssertEqual(ToDoState.done.toString(), "Done")
    }
}
