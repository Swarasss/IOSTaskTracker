//
//  ContentView.swift
//  tasktracker
//
//  Created by CS3714 on 10/8/25.
//

import SwiftUI
//This is the Front End of our project.
//The plus button is utilized to add new tasks.
//This dispalys all the buttons including the plus sign to add a task by navigating to the form.
//The edit task view here gives you a vie where you can edit the tak title, description, date, status.
//The view tasks completed button navigates to a view where you can view the tasks completed.
//Add and edit task categories navigates to the view where you can add and edit task
struct ContentView: View {
    @StateObject private var taskcategories = TaskCategory()
    @State private var viewforAddingTask = false
    @State private var showCategories = false
    @State private var showCompletedTasks = false
    var body: some View {
        NavigationStack {
            //Condition when there are no tasks yet.
            VStack {
                if taskcategories.tasks.isEmpty {
                    ContentUnavailableView("No tasks Yet",
                                           systemImage: "list.bullet.rectangle",
                                           description: Text("Tap the + button to add a new task"))
                }
                else {
                    TaskListView()
                        .environmentObject(taskcategories)
                }
            }
            //Used some features from SwiftUI styling.
            //added a Button for add and edit tasks
            Button("Add and Edit Task Categories") {
                showCategories = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
            //Added a button for showing completed tasks.
            Button("View tasks completed") {
                showCompletedTasks = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            .navigationTitle("Task Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewforAddingTask = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .accessibilityLabel("Add Task")
                }
            }
            //Navigation stack used to swith to different views via different buttons.
            .sheet(isPresented: $viewforAddingTask) {
                NavigationStack {
                    AddTasks()
                        .environmentObject(taskcategories)
                }
            }
            .sheet(isPresented: $showCategories) {
                NavigationStack {
                    CategoryListView()
                        .environmentObject(taskcategories)
                }
            }
            .sheet(isPresented: $showCompletedTasks) {
                NavigationStack {
                    CompletedTasksView()
                        .environmentObject(taskcategories)
                }
            }
        }
    }
}
    
















#Preview {
    ContentView()
}
