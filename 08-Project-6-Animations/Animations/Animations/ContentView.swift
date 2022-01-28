//
//  ContentView.swift
//  Animations
//
//  Created by Matt X on 1/24/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isEnabled = false
    @State private var dragAmount: CGSize = .zero
    
    let letters = Array("Hello SwiftUI")

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(isEnabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(
                        .default.delay(Double(num) / 20),
                        value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    isEnabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
