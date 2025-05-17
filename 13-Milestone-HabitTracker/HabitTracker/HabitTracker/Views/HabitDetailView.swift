//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Matt X on 2/9/22.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var habitVM: HabitViewModel
    @State var habit: Habit
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 20) {
                Text(habit.title)
                    .font(.title2.bold())
                    .foregroundStyle(habit.color ?? .gray)
                
                if !habit.description.isEmpty {
                    Text(habit.description)
                        .font(.title3.italic())
                }
            }
            .multilineTextAlignment(.center)
            .lineLimit(2)
            
            Text("^[\(habit.completionCount) completion](inflect: true)")
                .font(.title.bold())
            
            updateCountButton
        }
        .padding(.horizontal, 40)
    }
    
    private var updateCountButton: some View {
        Button {
            updateHabitCount()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(habit.color ?? .gray)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
    }
    
    private func updateHabitCount() {
        let index = habitVM.habits.firstIndex(of: habit)
        
        var newHabit = habit
        newHabit.completionCount += 1
        
        guard let index = index else { return }
        
        habitVM.habits[index] = newHabit
        // Update the @State habit to reflect the new one
        habit = newHabit
    }
}

#Preview {
    HabitDetailView(
        habitVM: HabitViewModel(),
        habit: HabitViewModel.sampleHabits[0]
    )
}
