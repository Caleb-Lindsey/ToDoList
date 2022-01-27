//
//  ToDoItem+CoreDataClass.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import Foundation
import CoreData

@objc(ToDoItem)
class ToDoItem: NSManagedObject {
    @NSManaged private var titleKey: String?
    
    @NSManaged var createdAt: Date?
    
    @NSManaged var state: ToDoState
    
    @NSManaged var priority: ToDoPriority
    
    var title: String {
        set { titleKey = newValue }
        get { return titleKey ?? "Unknown" }
    }
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }
}

// MARK: - Identifiable

extension ToDoItem : Identifiable {
    @NSManaged public var id: UUID?
}
