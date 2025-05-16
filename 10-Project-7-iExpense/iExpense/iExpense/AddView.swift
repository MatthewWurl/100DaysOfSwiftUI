//
//  AddView.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var type: ExpenseItem.ItemType = .personal
    @State private var amount: Double = 0
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseItem.ItemType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                
                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: currencyCode)
                )
                .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount
                    )
                    expenses.addItem(item)
                    dismiss()
                }
                .disabled(
                    name.trimmingCharacters(in: .whitespaces).isEmpty
                )
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
