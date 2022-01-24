//
//  ToDoItem+CoreDataClass.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import Foundation
import CoreData

@objc enum ToDoState: Int32 {
    case notStarted = 0
    case inProgress = 1
    case done = 2
    
    func toString() -> String {
        switch self {
        case .notStarted:
            return "Not Started"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}

@objc enum Priority: Int32, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2
    
    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    init?(_ integer: Int) {
        guard 0..<Priority.allCases.count ~= integer else { return nil }
        
        self.init(rawValue: Int32(integer))
    }
    
    static func getPriority(from integer: Int) -> Priority {
        switch integer {
        case 0:
            return .low
        case 1:
            return .medium
        case 2:
            return .high
        default:
            return .low
        }
    }
}

@objc(ToDoItem)
class ToDoItem: NSManagedObject {
    @NSManaged private var titleKey: String?
    
    @NSManaged var createdAt: Date?
    
    @NSManaged var state: ToDoState
    
    @NSManaged var priority: Priority
    
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

// MARK: - Previews

extension ToDoItem {
    static let preview: ToDoItem = {
        let toDoItem = ToDoItem()
        toDoItem.id = UUID()
        toDoItem.title = "Learn SwiftUI"
        toDoItem.priority = .high
        toDoItem.state = .done
        return toDoItem
    }()
}
