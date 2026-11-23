//
//  TaskPriority.swift
//  TaskManagerSwiftData
//
//  Created by Jayaram G on 20/11/26.
//
import Foundation
import SwiftUI
enum TaskPriority: String,Codable, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var id: String {
        rawValue
    }
    
    var symbol: String {
        switch self {
        case .low:
            return ""
        case .medium:
            return ""
        case .high:
            return ""
        }
    }
}
