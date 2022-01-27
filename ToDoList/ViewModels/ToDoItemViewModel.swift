//
//  ToDoItemViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Combine
import Foundation

class ToDoItemViewModel: ObservableObject, Identifiable {
    private let coreDataManager = CoreDataManager.shared
    private(set) var toDoItem: ToDoItem
    
    var id: UUID?
    var title: String
    var priority: ToDoPriority
    
    @Published var state: ToDoState {
        didSet {
            toDoItem.state = state
            
            coreDataManager.updateState(for: toDoItem, newState: state)
        }
    }
    
    init(toDoItem: ToDoItem) {
        self.toDoItem = toDoItem
        
        id = toDoItem.id
        title = toDoItem.title
        priority = toDoItem.priority
        state = toDoItem.state
    }
    
    func toggleState() {
        switch state {
        case .notStarted:
            state = .inProgress
        case .inProgress:
            state = .done
        case .done:
            state = .notStarted
        }
    }
}
