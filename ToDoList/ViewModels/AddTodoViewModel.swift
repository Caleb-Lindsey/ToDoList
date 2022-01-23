//
//  AddTodoViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Foundation

struct AddTodoViewModel {
    func add(title: String, priority: Priority = .low) {
        let newItem = ToDoItem(context: CoreDataManager.shared.viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.createdAt = Date()
        newItem.priority = priority
        newItem.state = .notStarted
        
        CoreDataManager.shared.save()
    }
}
