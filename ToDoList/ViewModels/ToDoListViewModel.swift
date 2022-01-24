//
//  ToDoItemsViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    @Published var toDoItemViewModels: [ToDoItemViewModel] = []
    
    var isEmpty: Bool {
        return toDoItemViewModels.isEmpty
    }
    
    func fetchToDoItems(completion: ((Error?) -> ())?) {
        CoreDataManager.shared.fetchToDoItems(completion: { result in
            switch result {
            case .success(let toDoItems):
                toDoItemViewModels = toDoItems.map(ToDoItemViewModel.init)
                
                completion?(nil)
            case .failure(let error):
                completion?(error)
            }
        })
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
