//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    let name: String
    let type: ItemType
    let amount: Double
    
    var id = UUID()
    
    enum ItemType: String, Codable, CaseIterable {
        case business = "Business"
        case personal = "Personal"
    }
}
