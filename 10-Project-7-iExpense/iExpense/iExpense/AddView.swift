//
//  AddView.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import SwiftUI

enum ExpenseType: String, CaseIterable {
    case business = "Business"
    case personal = "Personal"
    
    var description: String {
        self.rawValue
    }
}

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ExpenseType.allCases
    let currencyCode = Locale.current.currencyCode ?? "USD"
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.description) {
                        Text($0.description)
                    }
                }
                
                TextField("Amount",
                          value: $amount,
                          format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {    
                    let item = ExpenseItem(name: name,
                                           type: type,
                                           amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
