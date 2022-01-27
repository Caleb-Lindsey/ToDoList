//
//  AddToDoViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Foundation

class AddToDoViewModel {
    private let coreDataManager = CoreDataManager.shared
    
    func add(title: String, priority: ToDoPriority = .low, completion: ((Bool) -> ())?) {
        coreDataManager.addToDo(title: title, priority: priority, completion: completion)
    }
}
