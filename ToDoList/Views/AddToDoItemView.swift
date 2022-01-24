//
//  AddToDoItemView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/22/22.
//

import SwiftUI

struct AddToDoItemView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var alertContext = AlertContext()
    @State private var title = ""
    @State private var priorityValue = 0
    
    private let addTodoVM = AddTodoViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
                
                Section {
                    Picker("Priority", selection: $priorityValue) {
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
                    Button(action: add) {
                        Text("Save")
                    }
                }
            }
            .alert(context: alertContext)
        }
    }
    
    func add() {
        let priority = Priority(priorityValue) ?? .low
        addTodoVM.add(title: title, priority: priority) { success in
            success ? dismiss() : alertContext.present(AppAlert.addToDoError)
        }
    }
}

struct AddToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoItemView()
    }
}
