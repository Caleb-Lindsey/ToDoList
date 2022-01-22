//
//  ToDoItemsView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/21/22.
//

import SwiftUI

struct ToDoItemsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.createdAt)
    ]) var toDoItems: FetchedResults<ToDoItem>
    
    @State private var isPresentingAddView = false
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(toDoItems) { item in
                        Text(item.title ?? "Unknown")
                    }
                    .onDelete(perform: delete)
                } header: {
                    Text("Just do it")
                }

            }
            .navigationTitle("ToDoList")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresentingAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddView) {
                AddToDoItemView()
            }
        }
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let toDoItem = toDoItems[offset]
            moc.delete(toDoItem)
                        
            do {
                try moc.save()
            } catch {
                displayAlert("There was a problem deleting this ToDo")
            }
        }
    }
    
    // TODO: Figure out how to reuse alerts with SwiftUI
    func displayAlert(_ message: String) {
        alertTitle = message
        isShowingAlert = true
    }
}

struct ToDoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemsView()
    }
}
