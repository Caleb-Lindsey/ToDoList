//
//  View+Extensions.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import SwiftUI

extension View {
    func alert(context: AlertContext) -> some View {
        alert(isPresented: context.isActiveBinding, content: context.content)
    }
}
