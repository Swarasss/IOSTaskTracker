//
//  Taskist.swift
//  tasktracker
//
//  Created by CS3714 on 10/8/25.
//
import SwiftUI
import Foundation
//The purpose of this file is to dispaly the task list with the title and categories feature.
//The search function is also for future use since the having a search bar was not part of this project.
struct TaskListView: View {
    @EnvironmentObject var taskcategories: TaskCategory
    @State private var searchText = ""
    @State private var selectedTask: Task? = nil
   
    // Filtered tasks for search
    var taskFiltered: [Task] {
        if searchText.isEmpty {
            return taskcategories.tasks
        } else {
            return taskcategories.tasks.filter {
                $0.taskTitle.localizedCaseInsensitiveContains(searchText) ||
                $0.taskCategory.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
   
    var body: some View {
        List {
            // Use filtered tasks for search functionality
            ForEach($taskcategories.tasks) { $task in
                TaskRowView(task: $task, selectedTask: $selectedTask)
            }
            .onDelete { indexSet in
                taskcategories.removeTask(at: indexSet)
            }
        }
        //Searches for tasks and categories. Tho not completely working SwiftUI.
        .listStyle(.insetGrouped)
        .searchable(text: $searchText, prompt: "Search categories or tasks")
        .navigationTitle("My Tasks")
        .sheet(item: $selectedTask) { task in
            if let binding = binding(for: task) {
                EditTaskView(task: binding)
                    .environmentObject(taskcategories)
            }
        }
    }
    private func binding(for task: Task) -> Binding<Task>? {
        guard let index = taskcategories.tasks.firstIndex(where: { $0.id == task.id }) else {
            return nil
        }
        return Binding(
            get: { taskcategories.tasks[index] },
            set: { taskcategories.tasks[index] = $0 }
        )
    }
}
