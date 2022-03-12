//
//  EmptyImagePlaceholder.swift
//  RememberThem
//
//  Created by Matt X on 3/11/22.
//

import SwiftUI

struct EmptyImagePlaceholder: View {
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    color,
                    style: .init(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [5, 5])
                )
                .scaledToFit()
            
            Text("Tap to select an image")
                .foregroundColor(color)
                .font(.headline)
        }
    }
}

struct EmptyImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImagePlaceholder(color: .blue)
    }
}
