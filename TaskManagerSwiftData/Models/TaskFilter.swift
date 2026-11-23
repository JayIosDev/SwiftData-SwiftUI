//
//  TaskFilter.swift
//  TaskManagerSwiftData
//
//  Created by Jayaram G on 20/11/26.
//
import Foundation
import SwiftData

enum TaskFilter {
    case all
    case active
    case completed
    case overDue
    case highPriority
    
    var predicate: Predicate<Task> {
        switch self {
        case .all:
            return #Predicate{_ in true}
        case .active:
            return #Predicate{$0.isCompleted == false}
        case .completed:
            return #Predicate{$0.isCompleted}
        case .overDue:
            let now = Date()
            return  #Predicate{ task in
                task.dueDate != nil &&
                task.dueDate! < now &&
                                task.isCompleted == false
            }
        case .highPriority:
            return #Predicate{$0.priorityRaw == TaskPriority.high.rawValue}
        }
        
    }
    
    var displayName: String {
        switch self {
        case .all:
            "All"
        case .active:
            "Active"
        case .completed:
            "Completed"
        case .overDue:
            "Over Due"
        case .highPriority:
            "High Priority"
        }
    }
}
