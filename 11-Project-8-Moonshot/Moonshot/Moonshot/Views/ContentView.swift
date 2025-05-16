//
//  ContentView.swift
//  Moonshot
//
//  Created by Matt X on 1/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isShowingGrid {
                    GridLayout(
                        astronauts: Astronaut.allAstronauts,
                        missions: Mission.allMissions
                    )
                } else {
                    ListLayout(
                        astronauts: Astronaut.allAstronauts,
                        missions: Mission.allMissions
                    )
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Button("Show as \(isShowingGrid ? "List" : "Grid")") {
                        isShowingGrid.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
