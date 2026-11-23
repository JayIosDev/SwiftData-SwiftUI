//
//  TaskViewModel.swift
//  TaskManagerSwiftData
//
//  Created by Jayaram G on 20/11/26.
//
import Foundation
import Observation
import SwiftData

@Observable
class TaskViewModel {
    
    private let modelContext:ModelContext
    var isLoading = false
    var error: TaskError?
    
    var taskStatistics: TaskStatistics {
        let descriptor = FetchDescriptor<Task>()
        guard let allTasks = try? modelContext.fetch(descriptor) else {
            return TaskStatistics()
        }
        let totalCount = allTasks.count
        let completed = allTasks.filter(\.isCompleted).count
        let active = totalCount - completed
        let overDue = allTasks.filter(\.isOverDue).count
        
        return TaskStatistics(total: totalCount, active: active, overDue: overDue, completed: completed)
    }
    
    init(modelContext: ModelContext, isLoading: Bool) {
        self.modelContext = modelContext
        self.isLoading = isLoading
    }
    
    func createNewTask(title: String, description: String = "", priority: TaskPriority = .medium, dueDate: Date? = nil) -> [Task] throws {
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        guard !trimmedTitle.isEmpty  else {
            throw TaskError.emptyTitle
        }
        
        let task = Task(title: trimmedTitle, description: description, priority: priority, dueDate: dueDate, context: modelContext)
        
        modelContext.insert(task)
        do {
            try modelContext.save()
            self.error = nil
        }catch {
            self.error = .saveFailed
            throw TaskError.saveFailed
        }
    }
    
    func fetchTasks(filter: TaskFilter? = nil) -> [Task] {
        var descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        if let filter = filter {
            descriptor.predicate = filter.predicate
        }
     
        return (try modelContext.fetch(descriptor)) ?? []
    }
    
    func countTasks(filter: TaskFilter? = nil) -> Int {
        var descriptor = FetchDescriptor<Task>()
        if let filter = filter {
            descriptor.predicate = filter.predicate
        }
        return (try modelContext.fetchCount(descriptor)) ?? 0
    }
    
    func deleteTasks(_ task: [Task]) {
        
    }
}
