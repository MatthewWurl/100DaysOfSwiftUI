//
//  TrapezoidView.swift
//  Drawing
//
//  Created by Matt X on 2/6/22.
//

import SwiftUI

struct Trapzeoid: Shape {    
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        }
    }
}

struct TrapezoidView: View {
    @State private var insetAmount = 50.0
    
    var body: some View {
        Trapzeoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
            .navigationTitle("Trapezoid")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TrapezoidView()
    }
}
