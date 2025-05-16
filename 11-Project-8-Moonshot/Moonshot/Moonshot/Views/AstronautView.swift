//
//  AstronautView.swift
//  Moonshot
//
//  Created by Matt X on 2/2/22.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let name = "armstrong"
    
    NavigationStack {
        AstronautView(astronaut: Astronaut.allAstronauts[name]!)
            .preferredColorScheme(.dark)
    }
}
