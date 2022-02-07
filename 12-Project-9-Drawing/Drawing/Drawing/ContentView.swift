//
//  ContentView.swift
//  Drawing
//
//  Created by Matt X on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: FlowerView()) {
                    Text("Flower")
                }
                
                NavigationLink(destination: TrapezoidView()) {
                    Text("Trapezoid")
                }
                
                NavigationLink(destination: CheckerboardView()) {
                    Text("Checkerboard")
                }
                
                NavigationLink(destination: SpirographView()) {
                    Text("Spirograph")
                }
                
                NavigationLink(destination: ArrowView()) {
                    Text("Arrow")
                }
                
                NavigationLink(destination: ColorCyclingRectangleView()) {
                    Text("Color Cycling Rectangle View")
                }
            }
            .navigationTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
