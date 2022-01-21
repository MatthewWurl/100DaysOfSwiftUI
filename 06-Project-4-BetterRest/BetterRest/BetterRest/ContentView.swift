//
//  ContentView.swift
//  BetterRest
//
//  Created by Matt X on 1/18/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    // There is no longer a "Calculate" button, so therefore the
    // sleep time must be a computed property.
    private var sleepTime: Date? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute],
                                                             from: wakeUp)
            let hourSeconds = (components.hour ?? 0) * 60 * 60
            let minuteSeconds = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hourSeconds + minuteSeconds),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            
            // Time they need to go to bed...
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime
        } catch {
            return nil
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Desired wake-up time") {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12,
                            step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                }
                
                Section("Recommended bedtime") {
                    Text(sleepTime?.formatted(date: .omitted, time: .shortened) ?? "???")
                }
            }
            .navigationTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
