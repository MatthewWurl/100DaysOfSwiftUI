//
//  ArrowView.swift
//  Drawing
//
//  Created by Matt X on 2/7/22.
//

import SwiftUI

struct Arrow: Shape {
    var lineThickness: Double
    
    var animatableData: Double {
        get { lineThickness }
        set { lineThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            
            path.addLines([
                CGPoint(x: rect.minX, y: rect.midY),
                CGPoint(x: rect.maxX * 1/3, y: rect.midY),
                CGPoint(x: rect.maxX * 1/3, y: rect.maxY),
                CGPoint(x: rect.maxX * 2/3, y: rect.maxY),
                CGPoint(x: rect.maxX * 2/3, y: rect.midY),
                CGPoint(x: rect.maxX, y: rect.midY),
                CGPoint(x: rect.midX, y: rect.minY)
            ])
            
            path.closeSubpath()
        }
    }
}

struct ArrowView: View {
    @State private var lineThickness = 10.0
    @State private var rotationDegrees = 0.0
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Tap the arrow!")
                .italic()
                .padding(.bottom, 50)
            
            Arrow(lineThickness: lineThickness)
                .stroke(.blue, lineWidth: lineThickness)
                .rotationEffect(.degrees(rotationDegrees))
                .frame(width: 300, height: 300)
                .padding()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                        lineThickness = Double.random(in: 1...40)
                        rotationDegrees = Double.random(in: 0...360)
                    }
                }
        }
        .navigationTitle("Arrow")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ArrowView()
    }
}
