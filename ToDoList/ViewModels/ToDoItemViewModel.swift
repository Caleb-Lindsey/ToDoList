//
//  ToDoItemViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Foundation

class ToDoItemViewModel: ObservableObject, Identifiable {
    private(set) var toDoItem: ToDoItem
    
    var id: UUID?
    var title: String
    var priority: Priority
    
    @Published var state: ToDoState {
        didSet {
            toDoItem.state = state
            
            CoreDataManager.shared.save(completion: nil)
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
            break
        case .inProgress:
            state = .done
            break
        case .done:
            state = .notStarted
            break
        }
    }
}
