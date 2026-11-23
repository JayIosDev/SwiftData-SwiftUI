//
//  TaskError.swift
//  TaskManagerSwiftData
//
//  Created by Jayaram G on 20/11/26.
//
import Foundation

enum TaskError: LocalizedError {
    case emptyTitle
    case saveFailed
    case fetchFailed
    case deleteFailed
    
    
    
    var localizedDescription: String {
        switch self {
        case .emptyTitle:
            return "Title cannot be empty"
        case .saveFailed:
            return "Failed to save task"
        case .fetchFailed:
            return "Failed to fetch task"
        case .deleteFailed:
            return "Failed to delete task"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
            case .emptyTitle:
            return "Please enter a valid title"
        case .deleteFailed, .saveFailed:
            return "Please try again"
        case .fetchFailed:
            return "Check your database connection and try again"
        }
    }
}

