//
//  ContentView.swift
//  iExpense
//
//  Created by Matt X on 1/29/22.
//

import SwiftUI

struct StyledAmount: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        return content
            .foregroundColor(getAmountColor(for: amount))
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

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var isShowingAddExpense = false
    
    let currencyCode = Locale.current.currencyCode ?? "USD"
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount,
                             format: .currency(code: currencyCode))
                            .styledAmount(item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    isShowingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isShowingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
