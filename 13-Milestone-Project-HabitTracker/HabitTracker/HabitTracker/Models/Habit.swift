//
//  Habit.swift
//  HabitTracker
//
//  Created by Matt X on 2/8/22.
//

import Foundation
import SwiftUI

struct Habit: Codable, Equatable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let colorString: String? // Used to help with encoding/decoding
    var completionCount: Int = 0
    
    // The Habit color is computed based on the colorString
    var color: Color? {
        Color.habitColors.first(where: { $0.value == colorString })?.key
    }
}
