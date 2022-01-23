//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/21/22.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject private var toDoListVM = ToDoListViewModel()
    
    @State private var isPresentingAddView = false
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(toDoListVM.toDoItemViewModels) { item in
                        Text(item.title)
                    }
                    .onDelete(perform: toDoListVM.delete)
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
                toDoListVM.fetchToDoItems()
            } content: {
                AddToDoItemView()
            }
        }
        .onAppear(perform: toDoListVM.fetchToDoItems)
        .navigationViewStyle(.stack)
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) { }
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
        ToDoListView()
    }
}
