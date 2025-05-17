//
//  ContentView.swift
//  HabitTracker
//
//  Created by Matt X on 2/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habitVM = HabitViewModel()
    @State private var isShowingAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitVM.habits) { habit in
                    NavigationLink {
                        HabitDetailView(
                            habitVM: habitVM,
                            habit: habit
                        )
                    } label: {
                        HStack {
                            Text(habit.title)
                                .font(.headline)
                                .foregroundStyle(habit.color ?? .gray)
                                .lineLimit(2)
                            
                            Spacer(minLength: 40)
                            
                            Text("^[\(habit.completionCount) completion](inflect: true)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .onMove { indexSet, index in
                    habitVM.habits.move(fromOffsets: indexSet, toOffset: index)
                }
                .onDelete { offsets in
                    habitVM.habits.remove(atOffsets: offsets)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if habitVM.habits.count > 0 {
                        EditButton()
                    }
                    
                    Button {
                        isShowingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddHabit) {
                AddHabitView(habitVM: habitVM)
            }
        }
    }
}

#Preview {
    ContentView()
}
