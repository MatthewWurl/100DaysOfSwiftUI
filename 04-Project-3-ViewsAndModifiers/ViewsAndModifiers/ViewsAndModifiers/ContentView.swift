//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Matt X on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Challenge 3 - Prominent title
                Text("This is a prominent title!")
                    .prominentTitle()
                    .multilineTextAlignment(.center)
                    .padding()
                
                // View modifier is passed directly to .modifier()
                Text("Some text")
                    .modifier(CustomCapsule(color: .blue))
                
                // Custom .customCapsule() view modifier
                Text("Some other text")
                    .customCapsule(color: .green)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 80)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
            .padding(.horizontal)
        }
    }
}

struct CustomCapsule: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.white)
            .padding()
            .background(color)
            .clipShape(Capsule())
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func customCapsule(color: Color) -> some View {
        modifier(CustomCapsule(color: color))
    }
    
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

#Preview {
    ContentView()
}
