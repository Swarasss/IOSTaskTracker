//
//  TaskRow.swift
//  tasktracker
//
//  Created by CS3714 on 10/11/25.
// This also adds colors and updates and display the Task status in the tasks list.
import SwiftUI

struct TaskRowView: View {
    @Binding var task: Task
    @Binding var selectedTask: Task?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //Adds green when task is completed. Orange when it is in progress. Blue when the task still has to be started.
            HStack {
                task.image
                    .foregroundColor(
                        task.status == .taskComplete ? .green :
                        task.status == .taskContinuity ? .orange : .blue
                    )
                    .font(.title3)

                VStack(alignment: .leading, spacing: 4) {
                    Text(task.taskTitle)
                        .font(.headline)
                    Text(task.taskCategory)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            //Actually displays the Eit tasks Button over here.
            Button("Edit Task") {
                selectedTask = task
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .font(.caption)

            Picker("Status", selection: $task.status) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.menu)
            .tint(
                task.status == .taskComplete ? .green :
                task.status == .taskContinuity ? .orange : .blue
            )
        }
        .padding(.vertical, 4)
    }
}
