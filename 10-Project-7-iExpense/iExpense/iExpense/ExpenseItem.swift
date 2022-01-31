//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
