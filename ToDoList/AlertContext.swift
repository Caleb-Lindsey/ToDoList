//
//  AlertContext.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/23/22.
//

import Foundation
import SwiftUI

protocol AlertProvider {
    var alert: Alert { get }
}

enum AppAlert: AlertProvider {
    case fetchToDoError
    case addToDoError
    
    var alert: Alert {
        switch self {
        case .fetchToDoError:
            return Alert(title: Text("There was a problem loading your ToDos"))
        case .addToDoError:
            return Alert(title: Text("There was a problem adding your ToDo"))
        }
    }
}

class AlertContext: PresentationContext<Alert> {
    public override func content() -> Alert {
        contentView ?? Alert(title: Text("Encountered a problem"))
    }
    
    func present(_ provider: AlertProvider) {
        contentView = provider.alert
    }
}

class PresentationContext<Content>: ObservableObject {
    @Published var isActive = false
    
    var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
    
    var contentView: Content? {
        didSet { isActive = contentView != nil }
    }
    
    open func content() -> Content { contentView! }
    
    func dismiss() {
        isActive = false
    }
    
    func present(_ content: Content) {
        contentView = content
    }
}
