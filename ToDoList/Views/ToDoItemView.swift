//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import SwiftUI

struct ToDoItemView: View {
    @ObservedObject var toDoItemViewModel: ToDoItemViewModel
    
    private var stateColor: Color {
        switch toDoItemViewModel.state {
        case .notStarted:
            return .gray
        case .inProgress:
            return .yellow
        case .done:
            return .green
        }
    }
    
    @ViewBuilder
    private var priorityImage: some View {
        switch toDoItemViewModel.priority {
        case .low:
            EmptyView()
        case .medium:
            Image(systemName: "exclamationmark.2").foregroundColor(.orange)
        case .high:
            Image(systemName: "exclamationmark.3").foregroundColor(.red)
        }
    }
    
    var body: some View {
        let state = toDoItemViewModel.state
        
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItemViewModel.title)
                    .font(.title3)
                HStack {
                    Text(state.toString())
                        .font(.subheadline)
                        .foregroundColor(stateColor)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            Spacer()
            priorityImage
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(toDoItemViewModel: ToDoItemViewModel(toDoItem: ToDoItem.preview))
    }
}
