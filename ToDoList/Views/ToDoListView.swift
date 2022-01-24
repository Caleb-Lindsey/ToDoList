//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/21/22.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject private var toDoListVM = ToDoListViewModel()
    @StateObject private var alertContext = AlertContext()
    @State private var isPresentingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(toDoListVM.toDoItemViewModels) { itemViewModel in
                        ToDoItemView(toDoItemViewModel: itemViewModel)
                            .onTapGesture(count: 2) {
                                itemViewModel.toggleState()
                            }
                    }
                    .onDelete(perform: toDoListVM.delete)
                } header: {
                    Text("Double-Tap to update progress")
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
            .sheet(isPresented: $isPresentingAddView, onDismiss: fetchToDoItems) {
                AddToDoItemView()
            }
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: fetchToDoItems)
        .alert(context: alertContext)
    }
    
    func fetchToDoItems() {
        toDoListVM.fetchToDoItems { error in
            if error != nil {
                alertContext.present(AppAlert.fetchToDoError)
            }
        }
    }
}

struct ToDoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
