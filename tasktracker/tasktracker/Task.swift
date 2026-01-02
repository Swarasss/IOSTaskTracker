//
//  Task.swift
//  tasktracker
//
//  Created by CS3714 on 10/8/25.
//
import SwiftUI
import Foundation
//This is the Task struct where i declare all the variables that i use like the title, description, date, and status for the task.
enum TaskStatus: String, Codable, CaseIterable {
    case getStartedOn = "Task not begun"
    case taskContinuity = "Task is in progress"
    case taskComplete = "Task is completed"
}
//Struct declaring the variables.
struct Task: Identifiable, Hashable {
    let id = UUID()
    var taskTitle: String
    var taskDescription: String?
    var dueDate: Date
    var taskCategory: String
    var taskCompletionTime: Int
    var status: TaskStatus = .getStartedOn
    
    
    var image: Image {
        Image(systemName: status == .taskComplete ? "checkmark.circle.fill" : "circle")
    }
    
}
