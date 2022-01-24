//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import SwiftUI

struct ToDoItemView: View {
    @ObservedObject var toDoItemViewModel: ToDoItemViewModel
    
    var body: some View {
        let state = toDoItemViewModel.state
        
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItemViewModel.title)
                    .font(.title3)
                HStack {
                    Text(state.toString())
                        .font(.subheadline)
                        .foregroundColor(getStateColor())
                    Spacer()
                }
            }
            Spacer()
            
            let info = getPrioritySymbolInfo()
            if let name = info.0, let color = info.1 {
                Image(systemName: name).foregroundColor(color)
            }
        }
    }
    
    private func getPrioritySymbolInfo() -> (String?, Color?) {
        switch toDoItemViewModel.priority {
        case .low:
            return (nil, nil)
        case .medium:
            return ("exclamationmark.2", .orange)
        case .high:
            return ("exclamationmark.3", .red)
        }
    }
    
    private func getStateColor() -> Color {
        switch toDoItemViewModel.state {
        case .notStarted:
            return .gray
        case .inProgress:
            return .yellow
        case .done:
            return .green
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(toDoItemViewModel: ToDoItemViewModel(toDoItem: ToDoItem.preview))
    }
}
