//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/21/22.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ToDoItemsView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
