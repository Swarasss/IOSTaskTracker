//
//  TaskCateory.swift
//  tasktracker
//
//  Created by CS3714 on 10/9/25.
//
import Foundation
import SwiftUI
import Combine


final class TaskCategory: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var categories: [String] = ["College", "Personal care", "Leetcode Problems"]
   //I have added sample tasks in a list. Users can still add/Edit new tasks and Add/Remove categories.
    init() {
            
            tasks = [
                Task(taskTitle: "Swimming",
                     taskDescription: "Evening lap practice",
                     dueDate: Date().addingTimeInterval(3600),
                     taskCategory: "Personal care",
                     taskCompletionTime: 1,
                     status: .getStartedOn),
               
                Task(taskTitle: "CS3714 Midterm Project",
                     taskDescription: "Finish the iOS app",
                     dueDate: Date().addingTimeInterval(7200),
                     taskCategory: "College",
                     taskCompletionTime: 2,
                     status: .taskContinuity),
               
                Task(taskTitle: "Coding Interview Prep",
                     taskDescription: "Practice Leetcode medium questions",
                     dueDate: Date().addingTimeInterval(10800),
                     taskCategory: "Leetcode Problems",
                     taskCompletionTime: 3,
                     status: .taskComplete)
            ]
        }
    
    //Function to add a task
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    //Functions to remove tasks.

    func removeTask(_ task: Task) {
        tasks.removeAll {$0.id == task.id}
    }
    
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    //Functions to add categories
    
    func addCategory(_ name: String) {
        guard !categories.contains(where: {$0.caseInsensitiveCompare(name) == .orderedSame}) else {return}
        categories.append(name)
    }
    //Functions to remove categories.
    
    func removeCategory(_ name: String) {
        categories.removeAll {$0 == name}
    }
    
    func removeCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
    
    
    //Functions to toggle task ststus, to keeep track of task completion.
    
    func toggleTasks(_ task: Task) {
        guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {return}
        switch tasks[index].status {
        case .getStartedOn:
            tasks[index].status = .taskContinuity
        case .taskContinuity:
            tasks[index].status = .taskComplete
        case .taskComplete:
            tasks[index].status = .getStartedOn
        }
    }
}

