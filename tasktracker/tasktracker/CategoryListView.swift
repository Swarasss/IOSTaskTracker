//
//  CategoryListView.swift
//  tasktracker
//
//  Created by CS3714 on 10/10/25.
//
import SwiftUI
import Foundation
//This file is implemented for the button "Add and edit Categories" where I can delete the categories which I already have and I can also add and delete new categories.
struct CategoryListView: View {
    @EnvironmentObject var taskcategories: TaskCategory
    @State private var newCategory = ""
    //This dismiss variable that I created lets me access the 
    @Environment(\.dismiss) private var dismiss

    var body: some View {
      //This variable reads in all the categories.
        let categories = taskcategories.categories

        Form {
            Section(header: Text("Add New Category")) {
                HStack {
                    TextField("Enter category name", text: $newCategory)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addCategory) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    //SwiftUI styling
                    .disabled(newCategory.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }

            Section(header: Text("Existing Categories")) {
                //Conditions when there are no categories added yet.
                //This handles the remove categories function.
                //I also added a trash can so that the users can click on it to delete categories.
                if categories.isEmpty {
                    Text("No categories added yet.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(categories, id: \.self) { category in
                        HStack {
                            Text(category)
                            Spacer()
                            Button(role: .destructive) {
                                taskcategories.removeCategory(category)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    // This will allow the users to swipe to delete the categories
                    .onDelete { offsets in
                        
                        taskcategories.removeCategory(at: offsets)
                    }
                }
            }
        }
        //Then the frontend where it will display the actual tab and the heading says Manage categories. there is also a Done button to exit out.
        .navigationTitle("Manage Categories")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
    //This is a helper function to

    private func addCategory() {
        let trimmed = newCategory.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        taskcategories.addCategory(trimmed)
        newCategory = ""
    }
}
