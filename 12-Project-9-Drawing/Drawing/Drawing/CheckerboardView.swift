//
//  CheckerboardView.swift
//  Drawing
//
//  Created by Matt X on 2/6/22.
//

import SwiftUI

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let rowSize = rect.height / Double(rows)
            let columnSize = rect.width / Double(columns)
            
            for row in 0..<rows {
                for column in 0..<columns {
                    if (row + column).isMultiple(of: 2) {
                        let startX = columnSize * Double(column)
                        let startY = rowSize * Double(row)
                        
                        let rect = CGRect(x: startX, y: startY,
                                          width: columnSize, height: rowSize)
                        path.addRect(rect)
                    }
                }
            }
        }
    }
}

struct CheckerboardView: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
            .navigationTitle("Checkerboard")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CheckerboardView()
    }
}
