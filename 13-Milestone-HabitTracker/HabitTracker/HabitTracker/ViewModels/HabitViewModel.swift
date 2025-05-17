//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Matt X on 2/8/22.
//

import Foundation

class HabitViewModel: ObservableObject {
    private static let habitsKey = "Habits"
    
    @Published var habits = [Habit]() {
        didSet {
            guard let encodedData = try? JSONEncoder().encode(habits)
            else { return }
            
            UserDefaults.standard.set(encodedData, forKey: Self.habitsKey)
        }
    }
    
    init() {
        guard let savedHabits = UserDefaults.standard.data(forKey: Self.habitsKey)
        else { return }
        
        guard let decodedHabits = try? JSONDecoder().decode(
            [Habit].self,
            from: savedHabits
        ) else { return }
        
        habits = decodedHabits
    }
    
    static let sampleHabits = [
        Habit(
            title: "Sample habit 1",
            description: "Let's get to it!",
            colorString: "Orange"
        ),
        Habit(
            title: "Sample habit 2",
            description: "Get started now!",
            colorString: "Green"
        ),
        Habit(
            title: "Sample habit 3",
            description: "I can do this!",
            colorString: "Purple"
        )
    ]
}
