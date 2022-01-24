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
    
    func save(completion: ((Bool) -> ())?) {
        do {
            try viewContext.save()
            
            completion?(true)
        } catch {
            viewContext.rollback()
            
            completion?(false)
            
            print(error.localizedDescription)
        }
    }
    
    func fetchToDoItems(completion: ((Result<[ToDoItem], Error>) -> ())) {
        let request = ToDoItem.fetchRequest()
        
        do {
            let toDoItems = try viewContext.fetch(request)
            completion(.success(toDoItems))
        } catch {
            print(error.localizedDescription)
            
            completion(.failure(error))
        }
    }
    
    func delete(toDoItem: ToDoItem) {
        viewContext.delete(toDoItem)
        
        save(completion: nil)
    }
}
