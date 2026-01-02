//
//  EditTaskView.swift
//  tasktracker
//
//  Created by CS3714 on 10/11/25.
//
import SwiftUI
import Foundation
//This code handes the edit task button view displayed on each task, Where users can edit the title, description, date, and status of the task they newly aded  and for the sample tasks that I have made in a list.
struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var taskcategories: TaskCategory

    @Binding var task: Task

    var body: some View {
        Form {
            //Handles title edit option
            Section(header: Text("Task Details")) {
                //The code uses a custom binding for the description field o handle the optional taskDescription feature.
                //The getter returns the taskDescription value if it is not nil.
                //The setter updates the taskDescription feature with a new value.
                TextField("Title", text: $task.taskTitle)

                TextField("Description", text: Binding(
                    get: { task.taskDescription ?? "" },
                    set: { task.taskDescription = $0 }
                ))
            
                DatePicker("Due Date", selection: $task.dueDate)

                Picker("Category", selection: $task.taskCategory) {
                    ForEach(taskcategories.categories, id: \.self) { category in
                        Text(category)
                    }
                }

                Picker("Status", selection: $task.status) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
            }
            //Adds the title for the button and finally the exit or close button to navigate out of the button view.
            Section(header: Text("Actions")) {

                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Edit Task")
    }
}


