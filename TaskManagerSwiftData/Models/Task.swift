//
//  Task.swift
//  TaskManagerSwiftData
//
//  Created by Jayaram G on 20/11/26.
//
import Foundation
import SwiftUI
import SwiftData

@Model
final class Task {
    var id: UUID
    var title: String
    var taskDescription: String
    var isCompleted: Bool
    var createdAt: Date
    var updatedAt: Date
    var priorityRaw: String
    var dueDate: Date?
    
    @Transient
    var priority: TaskPriority {
        get {
            TaskPriority(rawValue: priorityRaw) ?? .medium
        }
        set {
            self.priorityRaw = newValue.rawValue
        }
    }
    
    @Transient
    var displayTitle: String {
        title.isEmpty ? "Untitled Task" : title
    }
    
    @Transient
    var isOverDue:Bool {
        guard let dueDate = dueDate else {return false}
        return !isCompleted && dueDate < Date()
    }
    
    @Transient
    var formattedCreatedDate: String {
        createdAt.formatted(date: .abbreviated, time: .shortened)
    }
    
    @Transient
    var formattedUpdatedDate: String {
        updatedAt.formatted(date: .abbreviated, time: .shortened)
    }
    
    init(title: String, taskDescription: String = "", priority: TaskPriority = .medium, dueDate: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.priorityRaw = priority.rawValue
        self.taskDescription = taskDescription
        self.isCompleted = false
        let date = Date()
        self.createdAt = date
        self.updatedAt = date
        self.dueDate = dueDate
    }
    
    func touch() {
        updatedAt = Date()
    }
    
    func toggleCompletion() {
        isCompleted.toggle()
        touch()
    }
    
}

extension Task {
    
    static var sampleTask: Task {
        return Task(title: "DevTechie Task", taskDescription: "Task For DevTechie to Finish", priority: .medium)
    }
    
    static var sampleTasks: [Task] {
        return [
            Task(title: "Finish Foundation Models", taskDescription: "Finish and Record New Course", priority: .high, dueDate: Date().addingTimeInterval(86400)),
            
            Task(title: "Record new swift data course", taskDescription: "Continue to work on new course", priority: .medium, dueDate: Date().addingTimeInterval(86400)),
            
            Task(title: "Workout", taskDescription: "Don't forget to go for workout", priority: .medium),
            
            Task(title: "Finish Foundation Models", taskDescription: "Finish and Record New Course", priority: .high, dueDate: Date().addingTimeInterval(86400)),
        ]
    }
}
