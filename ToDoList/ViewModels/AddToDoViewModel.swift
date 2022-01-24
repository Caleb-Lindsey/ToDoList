//
//  AddToDoViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Foundation

struct AddToDoViewModel {
    func add(title: String, priority: Priority = .low, completion: ((Bool) -> ())?) {
        CoreDataManager.shared.addToDo(title: title, priority: priority, completion: completion)
    }
}
