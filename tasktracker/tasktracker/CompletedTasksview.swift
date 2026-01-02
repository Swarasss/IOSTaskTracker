//
//  CompletedTasksview.swift
//  tasktracker
//
//  Created by CS3714 on 10/11/25.
//
import SwiftUI
import Foundation
//This file implements the function for the "View tasks completed button". Where you can view a list of all the tasks which are completed. i.e ststus showing completed.
struct CompletedTasksView: View {
    @EnvironmentObject var taskcategories: TaskCategory
    @Environment(\.dismiss) private var dismiss
    // Filter only completed tasks
    var completedTasks: [Task] {
        taskcategories.tasks.filter { $0.status == .taskComplete }
    }
    
    var body: some View {
        //This code handles the case where it displays a list of all the completed tasks. If there are no completed tasks, It shows a contentUnavailable view with a message.
        List {
            if completedTasks.isEmpty {
                ContentUnavailableView("No Completed Tasks Yet",
                                       systemImage: "checkmark.circle",
                                       description: Text("Mark a task as completed to see it here!"))
            } else {
                ForEach(completedTasks) { task in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(task.taskTitle)
                                .font(.headline)
                            Text(task.taskCategory)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Completed by: \(task.dueDate.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        //Finally the completed tasks button for the title and the exit button to navigate out of the tab.
        .navigationTitle("Completed Tasks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
