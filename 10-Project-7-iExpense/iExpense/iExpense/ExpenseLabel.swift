//
//  ExpenseLabel.swift
//  iExpense
//
//  Created by Matt W on 5/13/25.
//

import SwiftUI

struct ExpenseLabel: View {
    let item: ExpenseItem
    
    private let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    init(for item: ExpenseItem) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.type.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(
                item.amount,
                format: .currency(code: currencyCode)
            )
            .styledAmount(item.amount)
        }
        .accessibilityLabel(
            "\(item.name), \(item.amount) \(currencyCode)"
        )
        .accessibilityHint(item.type.rawValue)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ExpenseLabel(
        for: ExpenseItem(
            name: "MacBook Pro",
            type: .business,
            amount: 2499.99
        )
    )
    .padding()
}
