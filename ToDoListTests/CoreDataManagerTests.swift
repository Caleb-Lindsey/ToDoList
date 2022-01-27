//
//  CoreDataManagerTests.swift
//  ToDoListTests
//
//  Created by Caleb Lindsey on 1/26/22.
//

import Combine
import XCTest
@testable import ToDoList

class CoreDataManagerTests: XCTestCase {
    let coreDataManager = CoreDataManager.shared
    var toDoItems: [ToDoItem] = []
    private var cancellables = Set<AnyCancellable>()
        
    override func setUp() {
        if toDoItems.isEmpty {
            coreDataManager.addToDo(title: "someTitle1", priority: .low, state: .notStarted) { success in
                XCTAssertTrue(success)
            }
            
            coreDataManager.addToDo(title: "someTitle2", priority: .low, state: .notStarted) { success in
                XCTAssertTrue(success)
            }
            
            coreDataManager.addToDo(title: "someTitle3", priority: .low, state: .notStarted) { success in
                XCTAssertTrue(success)
            }
            
            coreDataManager.$savedToDoItems
            .sink { [weak self] (toDoItems) in
                self?.toDoItems = toDoItems
            } .store(in: &cancellables)
        }
    }
    
    func testAddToDoItemsFailure() {
        coreDataManager.addToDo(title: "") { success in
            XCTAssertFalse(success)
        }
        
        coreDataManager.addToDo(title: "This is a ToDo with more than 50 characters which should not be allowed.") { success in
            XCTAssertFalse(success)
        }
    }
    
    func testUpdateToDoItemsSuccess() {
        for toDoItem in toDoItems {
            coreDataManager.updateState(for: toDoItem, newState: .done)
            XCTAssertEqual(toDoItem.state, .done)
        }
    }
    
    func testDeleteToDoItemsSuccess() {
        XCTAssertFalse(toDoItems.isEmpty)
        
        for toDoItem in toDoItems {
            coreDataManager.delete(toDoItem: toDoItem)
        }
        
        XCTAssertTrue(toDoItems.isEmpty)
    }
}
