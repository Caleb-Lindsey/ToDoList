//
//  AddToDoItemView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import SwiftUI

struct AddToDoItemView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var priority = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
                
                Section {
                    Picker("Priority", selection: $priority) {
                        ForEach(0..<Priority.allCases.count) { index in
                            Text(Priority.allCases[index].title)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Priority")
                }
            }
            .navigationTitle("ToDo Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        add()
                    }
                }
            }
        }
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func add() {
        let newItem = ToDoItem(context: moc)
        newItem.id = UUID()
        newItem.title = title
        newItem.createdAt = Date()
        newItem.priority = Priority.getPriority(from: priority)
        newItem.state = .notStarted
        
        do {
            try moc.save()
            dismiss()
        } catch {
            displayAlert("There was a problem saving this ToDo")
        }
    }
    
    // TODO: Figure out how to reuse alerts with SwiftUI
    func displayAlert(_ message: String) {
        alertTitle = message
        isShowingAlert = true
    }
}

struct AddToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoItemView()
    }
}
