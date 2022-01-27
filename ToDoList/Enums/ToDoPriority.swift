//
//  ToDoPriority.swift
//  ToDoList
//
//  Created by Caleb Lindsey on 1/26/22.
//

import Foundation

@objc enum ToDoPriority: Int32, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2
    
    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    init?(_ integer: Int) {
        guard 0..<ToDoPriority.allCases.count ~= integer else { return nil }
        
        self.init(rawValue: Int32(integer))
    }
}
