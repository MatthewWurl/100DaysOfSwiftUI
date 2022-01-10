//
//  ContentView.swift
//  WeSplit
//
//  Created by Matt X on 1/8/22.
//

import SwiftUI

struct ContentView: View {
<<<<<<< HEAD
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let total = checkAmount + tipValue
        
        return total
    }
    
    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("Tip percentage")
                }
                
                Section {
                    Text(grandTotal, format: currencyCode)
                } header: {
                    Text("Total amount after tip")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
=======
    var body: some View {
        Text("Hello, world!")
            .padding()
>>>>>>> 6eb3fc545fcbf1e5ab9824c388815b0b3ec48eff
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
<<<<<<< HEAD
        // @FocusState crashes XCode when used in top-level View...
        // Embedding in a ZStack fixes the issue.
        ZStack {
            ContentView()
        }
=======
        ContentView()
>>>>>>> 6eb3fc545fcbf1e5ab9824c388815b0b3ec48eff
    }
}
