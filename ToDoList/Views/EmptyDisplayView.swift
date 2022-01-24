//
//  EmptyDisplayView.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/24/22.
//

import SwiftUI

struct EmptyDisplayView: View {
    let gradient = LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var action: (() -> ())
    
    init(action: (@escaping () -> ())) {
        self.action = action
    }
    
    var body: some View {
        VStack {
            Text("Hmm, looks like you don't have any ToDos...")
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding()
                
            Button(action: action) {
                Text("Create a ToDo")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 150, height: 40)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Capsule()
                .stroke(gradient, lineWidth: 2)
                .saturation(1.8))
        }
    }
}

struct EmptyDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDisplayView {}
    }
}
