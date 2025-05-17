//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Matt X on 2/8/22.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habitVM: HabitViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var color: Color = .blue
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Habit title", text: $title)
                    
                    TextField("Habit description", text: $description)
                }
                
                Section("Color") {
                    CustomColorPicker(selectedColor: $color)
                }
            }
            .navigationTitle("Add a new habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let newHabit = Habit(
                            title: title,
                            description: description,
                            // I need to update the actual colorString to be encoded/decoded,
                            // not the computed color property.
                            colorString: Color.habitColors[color, default: nil]
                        )
                        habitVM.habits.append(newHabit)
                        
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddHabitView(habitVM: HabitViewModel())
}
