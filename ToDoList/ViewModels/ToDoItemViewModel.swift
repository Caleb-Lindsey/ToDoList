//
//  ToDoItemViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Foundation

struct ToDoItemViewModel: Identifiable {
    let toDoItem: ToDoItem
    
    var id: UUID? {
        return toDoItem.id
    }
    
    var title: String {
        return toDoItem.title
    }
}
