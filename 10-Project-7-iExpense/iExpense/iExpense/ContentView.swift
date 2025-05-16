//
//  ContentView.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var isShowingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Expense type", selection: $expenses.selectedItemType) {
                    ForEach(
                        ExpenseItem.ItemType.allCases.reversed(),
                        id: \.self
                    ) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                
                Section {
                    ForEach(
                        expenses.items.filter {
                            $0.type == expenses.selectedItemType
                        }
                    ) { item in
                        ExpenseLabel(for: item)
                    }
                    .onDelete(perform: expenses.removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("New expense", systemImage: "plus") {
                    isShowingAddExpense = true
                }
            }
            .sheet(isPresented: $isShowingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct StyledAmount: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        return content
            .foregroundStyle(getAmountColor(for: amount))
    }
    
    func getAmountColor(for amount: Double) -> Color {
        switch amount {
        case ..<10: return Color.green
        case 10..<100: return Color.blue
        case 100...: return Color.purple
        default: return Color.black
        }
    }
}

extension View {
    func styledAmount(_ amount: Double) -> some View {
        modifier(StyledAmount(amount: amount))
    }
}

#Preview {
    ContentView()
}
