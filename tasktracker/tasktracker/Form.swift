//
//  Form.swift
//  tasktracker
//
//  Created by CS3714 on 10/9/25.
import SwiftUI
import Foundation
//This file has the form in the form of a sheet where users can add tasks.
struct AddTasks: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var taskcategories: TaskCategory
    @State private var taskTitle = ""
    @State private var taskDescription = ""
    @State private var selectedCategory  = "College"
    @State private var dueDate = Date()
    @State private var estimatedTime = 0
    @State private var showAlert = false
    //It gives users an option to add task title, due date, status of completion, and description which is optional.
    var body: some View {
        Form {
            TextField("TaskTitle", text: $taskTitle)
            TextField("TaskDescription", text: $taskDescription)
            DatePicker("Duedate", selection: $dueDate)
            Picker("TaskCategory", selection: $selectedCategory) {
                ForEach(taskcategories.categories, id: \.self) { cat in
                Text(cat)
                }
            }
            //This Stepper feature actually handles the dispaly of the due date and estimated time it would take. Like users would be ble to add the estimated time from 1 o 100.
            Stepper("Estimated Time: \(estimatedTime) hours", value: $estimatedTime, in: 0...100)
            
            HStack {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }

                Spacer()

                Button {
                    guard !taskTitle.isEmpty else {
                        showAlert = true
                        return
                    }

                    let addNewTask = Task(
                        taskTitle: taskTitle,
                        taskDescription: taskDescription,
                        dueDate: dueDate,
                        taskCategory: selectedCategory,
                        taskCompletionTime: estimatedTime
                    )

                    taskcategories.addTask(addNewTask)
                    dismiss()
                } label: {
                    Text("Save")
                        .bold()
                }
            }
        }
        .alert("Title for the task", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        
        }
        .navigationTitle("Add tasks")
    }
    
}


