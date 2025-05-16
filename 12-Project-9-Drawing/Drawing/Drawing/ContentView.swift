//
//  ContentView.swift
//  Drawing
//
//  Created by Matt X on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Flower", destination: FlowerView())
                
                NavigationLink("Trapezoid", destination: TrapezoidView())
                
                NavigationLink("Checkerboard", destination: CheckerboardView())
                
                NavigationLink("Spirograph", destination: SpirographView())
                
                NavigationLink("Arrow", destination: ArrowView())
                
                NavigationLink(
                    "Color Cycling Rectangle View",
                    destination: ColorCyclingRectangleView()
                )
            }
            .navigationTitle("Drawing")
        }
    }
}

#Preview {
    ContentView()
}
