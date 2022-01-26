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
    
    var body: some View {
        NavigationView {
            Group {
                if toDoListVM.isEmpty {
                    VStack(alignment: .center) {
                        EmptyDisplayView {
                            isPresentingAddView.toggle()
                        }
                        Spacer()
                    }
                } else {
                    List {
                        Section {
                            ForEach(toDoListVM.toDoItemViewModels) { itemViewModel in
                                ToDoItemView(toDoItemViewModel: itemViewModel) {
                                    itemViewModel.toggleState()
                                }
                            }
                            .onDelete(perform: toDoListVM.delete)
                        } header: {
                            Text("Double-Tap to update progress")
                        }
                    }
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
        .navigationViewStyle(.stack)
    }
}

struct ToDoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
