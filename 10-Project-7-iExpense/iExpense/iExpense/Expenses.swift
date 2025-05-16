//
//  Expenses.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import Foundation

class Expenses: ObservableObject {
    private let itemsKey = "Items"
    
    @Published var selectedItemType: ExpenseItem.ItemType = .personal
    
    @Published private(set) var items: [ExpenseItem] = [] {
        didSet {
            guard let encoded = try? JSONEncoder().encode(items) else { return }
            
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        }
    }
    
    init() {
        guard let savedItems = UserDefaults.standard.data(forKey: itemsKey)
        else { return }
        
        guard let decoded = try? JSONDecoder().decode(
            [ExpenseItem].self,
            from: savedItems
        ) else { return }
        
        items = decoded
    }
    
    func addItem(_ newItem: ExpenseItem) {
        items.append(newItem)
    }
    
    func removeItems(at offsets: IndexSet) {
        // Can no longer remove use `items.remove(at: offsets)` due to filtering...
        for offset in offsets {
            let itemToRemove = items.filter { $0.type == selectedItemType }[offset]
            let originalIndex = items.firstIndex { $0.id == itemToRemove.id }!
            
            items.remove(at: originalIndex)
        }
    }
}
