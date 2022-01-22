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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
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
