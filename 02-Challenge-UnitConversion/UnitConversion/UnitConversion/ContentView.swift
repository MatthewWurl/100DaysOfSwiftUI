//
//  ContentView.swift
//  UnitConversion
//
//  Created by Matt X on 1/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNum: Double?
    @State private var inputUnits: UnitLength = .meters
    @State private var outputUnits: UnitLength = .feet
    @FocusState private var inputNumIsFocused: Bool
    
    var outputNum: Double? {
        guard let inputNum = inputNum else { return nil }
        
        let inputMeasurement = Measurement(value: inputNum, unit: inputUnits)
        
        return inputMeasurement.converted(to: outputUnits).value
    }
    
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    var body: some View {
        NavigationStack {
            Form {
                // First section - Input units
                Section("Input Units") {
                    Picker("Input units", selection: $inputUnits) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowBackground(Color.clear)
                
                // Second section - Output units
                Section("Output Units") {
                    Picker("Output units", selection: $outputUnits) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowBackground(Color.clear)
                
                // Third section - Input number
                Section("Input number") {
                    TextField("Enter a number", value: $inputNum, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputNumIsFocused)
                }
                
                // Fourth section - Output number
                Section("Result") {
                    Text(outputNum?.formatted() ?? "")
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputNumIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
