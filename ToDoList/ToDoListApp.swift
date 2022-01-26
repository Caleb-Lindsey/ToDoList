//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/21/22.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
        }
    }
    
    init() {
        let userDefaults = UserDefaults.standard
        let firstLaunchKey = "firstLaunch"
        
        if !userDefaults.bool(forKey: firstLaunchKey) {
            userDefaults.set(true, forKey: firstLaunchKey)
            
            injectDefaultToDos()
        }
    }
    
    private func injectDefaultToDos() {
        let coreDataManager = CoreDataManager.shared
        coreDataManager.addToDo(title: "Check Emails", completion: nil)
        coreDataManager.addToDo(title: "Finish ToDoList App", priority: .high, state: .done, completion: nil)
        coreDataManager.addToDo(title: "Learn SwiftUI", priority: .medium, state: .inProgress, completion: nil)
    }
}
