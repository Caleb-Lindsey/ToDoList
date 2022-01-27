//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import CoreData
import Foundation

class CoreDataManager: ObservableObject {
    // TODO: Learn more Combine and get rid of singleton
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    @Published var savedToDoItems: [ToDoItem] = []
    
    private init() {
        container = NSPersistentContainer(name: "ToDoList")
        
#if TESTING
        // Allow inMemory store for Unit Tests
        if let storeDescription = container.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
            storeDescription.shouldAddStoreAsynchronously = false
        }
#endif
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        getToDoItems()
    }
    
    // MARK: - Private Methods
    
    private func getToDoItems() {
        let request = ToDoItem.fetchRequest()
        
        do {
            savedToDoItems = try container.viewContext.fetch(request)
        } catch {
            print("Problem fetching ToDos: \(error)")
        }
    }
    
    // MARK: - Internal Methods
    
    func save(completion: ((Bool) -> ())?) {
        do {
            try container.viewContext.save()
            
            getToDoItems()

            completion?(true)
        } catch {
            container.viewContext.rollback()

            completion?(false)
        }
    }
    
    func addToDo(title: String, priority: ToDoPriority = .low, state: ToDoState = .notStarted, completion: ((Bool) -> ())?) {
        let newItem = ToDoItem(context: container.viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.createdAt = Date()
        newItem.priority = priority
        newItem.state = state

        save(completion: completion)
    }
    
    func updateState(for toDoItem: ToDoItem, newState: ToDoState) {
        guard let toDoItem = (savedToDoItems.first { $0.id == toDoItem.id }) else { return }
        
        toDoItem.state = newState
        
        save(completion: nil)
    }

    func delete(toDoItem: ToDoItem) {
        container.viewContext.delete(toDoItem)

        save(completion: nil)
    }
}
