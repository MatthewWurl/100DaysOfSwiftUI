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
        UITableView.appearance().backgroundColor = UIColor(Color.darkBackground)
        
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
    }
}

struct ListLayout_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListLayout(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
