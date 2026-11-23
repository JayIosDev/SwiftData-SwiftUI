//
//  TaskStatistics.swift
//  TaskManagerSwiftData
//
//  Created by Jayaram G on 20/11/26.
//
import Foundation

 struct TaskStatistics {
     var total: Int = 0
     var active: Int = 0
     var completed: Int = 0
     var overDue: Int = 0
     
     var completedPercentage: Double {
         guard total > 0 else {return 0}
         return 100 * Double(completed) / Double(total)
     }
}

