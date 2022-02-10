//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Matt X on 2/9/22.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var habitViewModel: HabitViewModel
    @State var habit: Habit
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                Text(habit.title)
                    .font(.title.bold())
                    .foregroundColor(habit.color ?? .black)
                
                if !habit.description.isEmpty {
                    Text(habit.description)
                        .bold()
                        .italic()
                        .multilineTextAlignment(.center)
                }
            }
            
            VStack {
                Text("Completion count:")
                    .font(.title2)
                
                Text("\(habit.completionCount)")
                    .font(.largeTitle.bold())
            }
            
            Button {
                updateHabitCount()
            } label: {
                ZStack {
                    Circle()
                        .fill(habit.color ?? .black)
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func updateHabitCount() {
        let index = habitViewModel.habits.firstIndex(of: habit)
        
        var newHabit = habit
        newHabit.completionCount += 1
        
        if let index = index {
            habitViewModel.habits[index] = newHabit
            // Update the @State habit to reflect the new one
            habit = newHabit
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(
            habitViewModel: HabitViewModel(),
            habit: HabitViewModel.sampleHabits[0]
        )
    }
}
