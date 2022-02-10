//
//  CustomColorPicker.swift
//  HabitTracker
//
//  Created by Matt X on 2/8/22.
//

import SwiftUI

// This CustomColorPicker was inspired by Andrew Jackson's
// Medium post found here:
// https://medium.com/swlh/creating-a-curated-color-picker-in-swiftui-18a9a86f7721
// I take no credit for this!
struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    
    let colors: [Color] = [
        .red, .orange, .yellow, .green,
        .blue, .indigo, .purple, .pink
    ]
    
    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 60)),
        ]
        
        LazyVGrid(columns: columns) {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            selectedColor = color
                        }
                        .padding(10)
                    
                    if selectedColor == color {
                        Circle()
                            .stroke(color, lineWidth: 5)
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
    }
}

struct CustomColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomColorPicker(selectedColor: .constant(.blue))
    }
}
