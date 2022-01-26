//
//  ToDoItemsViewModel.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import Combine
import Foundation

class ToDoListViewModel: ObservableObject {
    private let coreDataManager = CoreDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var toDoItemViewModels: [ToDoItemViewModel] = []
    
    var isEmpty: Bool {
        return toDoItemViewModels.isEmpty
    }
    
    init() {
        coreDataManager.$savedToDoItems
        .sink { [weak self] (toDoItems) in
            self?.toDoItemViewModels = toDoItems.map(ToDoItemViewModel.init)
        } .store(in: &cancellables)
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let toDoItem = toDoItemViewModels[offset].toDoItem
            coreDataManager.delete(toDoItem: toDoItem)
        }
    }
}
