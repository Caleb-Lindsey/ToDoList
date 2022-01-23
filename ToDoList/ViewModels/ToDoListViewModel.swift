//
//  ToDoItemsViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    @Published var toDoItemViewModels: [ToDoItemViewModel] = []
    
    func fetchToDoItems() {
        toDoItemViewModels = CoreDataManager.shared.fetchToDoItems().map(ToDoItemViewModel.init)
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let toDoItemViewModel = toDoItemViewModels[offset]
            toDoItemViewModels.remove(at: offset)

            let toDoItem = toDoItemViewModel.toDoItem
            CoreDataManager.shared.delete(toDoItem: toDoItem)
        }
    }
}
