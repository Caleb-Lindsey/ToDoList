//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import SwiftUI

struct ToDoItemView: View {
    @ObservedObject var toDoItemViewModel: ToDoItemViewModel
    
    var doubleTapAction: (() -> Void)
    
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
    
    init(toDoItemViewModel: ToDoItemViewModel, doubleTapAction: @escaping (() -> Void)) {
        self.toDoItemViewModel = toDoItemViewModel
        self.doubleTapAction = doubleTapAction
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
            .padding(.leading, 4)
            Spacer()
            priorityImage
        }
        .contentShape(Rectangle())
        .onTapGesture(count: 2, perform: doubleTapAction)
    }
}
