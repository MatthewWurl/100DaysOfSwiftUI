//
//  ListLayout.swift
//  Moonshot
//
//  Created by Matt X on 2/3/22.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        return List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.vertical)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            
                            Text(mission.abbreviatedLaunchDate)
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
            .listRowSeparatorTint(.lightBackground)
        }
        .background(.darkBackground)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ListLayout(
        astronauts: Astronaut.allAstronauts,
        missions: Mission.allMissions
    )
    .preferredColorScheme(.dark)
}
