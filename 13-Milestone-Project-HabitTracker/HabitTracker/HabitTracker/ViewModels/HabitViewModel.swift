//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Matt X on 2/8/22.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            if let encodedData = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encodedData, forKey: Self.habitsKey)
            }
        }
    }
    
    private static let habitsKey = "Habits"
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: Self.habitsKey) {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
                return
            }
        }
        
        // No saved habits found...
        habits = []
    }
    
    static let sampleHabits = [
        Habit(title: "Sample habit 1", description: "Let's get to it!", colorString: "Orange"),
        Habit(title: "Sample habit 2", description: "Get started now!", colorString: "Green"),
        Habit(title: "Sample habit 3", description: "I can do this!", colorString: "Purple")
    ]
}
