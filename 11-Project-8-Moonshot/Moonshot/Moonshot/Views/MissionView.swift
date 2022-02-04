//
//  MissionView.swift
//  Moonshot
//
//  Created by Matt X on 2/2/22.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    @State private var rotationAngle: Angle = .zero
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometryProxy.size.width * 0.6)
                        .padding(.top)
                        .rotation3DEffect(rotationAngle,
                                          axis: (x: 0, y: 1, z: 0))
                        .onTapGesture {
                            withAnimation() {
                                rotationAngle = .degrees(360)
                            }
                            
                            rotationAngle = .zero
                        }
                    
                    Text("Tap me!")
                        .font(.caption)
                        .italic()
                    
                    VStack(alignment: .leading) {
                        CustomDivider()
                        
                        Text("Launch Date")
                            .sectionHeadingStyle()
                        
                        Text(mission.completeLaunchDate)
                        
                        CustomDivider()
                        
                        Text("Mission Highlights")
                            .sectionHeadingStyle()
                        
                        Text(mission.description)
                        
                        CustomDivider()
                        
                        Text("Crew")
                            .sectionHeadingStyle()
                    }
                    .padding(.horizontal)
                    
                    CrewScrollView(crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            // Who was this person?
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name).")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
