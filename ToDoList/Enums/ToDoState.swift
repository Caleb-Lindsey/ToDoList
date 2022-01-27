//
//  ToDoState.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/26/22.
//

import Foundation

@objc enum ToDoState: Int32 {
    case notStarted = 0
    case inProgress = 1
    case done = 2
    
    func toString() -> String {
        switch self {
        case .notStarted:
            return "Not Started"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}
