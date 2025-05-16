//
//  ColorCyclingRectangleView.swift
//  Drawing
//
//  Created by Matt X on 2/7/22.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    color(of: value, brightness: 1),
                                    color(of: value, brightness: 0.8)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(of value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 { targetHue -= 1 }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
                .padding(.horizontal)
        }
        .navigationTitle("Color Cycling Rectangle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ColorCyclingRectangleView()
    }
}
