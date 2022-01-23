//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container = NSPersistentContainer(name: "ToDoList")
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            
            print(error.localizedDescription)
        }
    }
    
    func fetchToDoItems() -> [ToDoItem] {
        let request = ToDoItem.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            
            return []
        }
    }
    
    func delete(toDoItem: ToDoItem) {
        viewContext.delete(toDoItem)
        
        save()
    }
}
