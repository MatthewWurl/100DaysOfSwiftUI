//
//  PersonDetailView.swift
//  RememberThem
//
//  Created by Matt X on 3/10/22.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    var person: Person
    
    let deltaSpan = 0.0025
    
    var body: some View {
        VStack(spacing: 20) {
            person.image?
                .resizable()
                .scaledToFit()
            
            if let coordinate = person.coordinate {
                VStack {
                    LocationMetLabel(title: "Here's where you met them", status: .known)
                        .font(.headline)
                    
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: .init(latitude: coordinate.latitude, longitude: coordinate.longitude), span: .init(latitudeDelta: deltaSpan, longitudeDelta: deltaSpan))), annotationItems: [person]) { _ in
                        MapAnnotation(coordinate: coordinate) {
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            } else {
                // No location found...
                LocationMetLabel(title: "Unknown meeting location...", status: .unknown)
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct PersonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetailView()
//    }
//}
