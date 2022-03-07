//
//  Location.swift
//  BucketList
//
//  Created by Matt X on 3/3/22.
//

import CoreLocation
import Foundation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let sampleLocation = Location(
        id: UUID(),
        name: "Buckingham Palace",
        description: "Where Queen Elizabeth lives with her dorgis",
        latitude: 51.501,
        longitude: -0.141
    )
}
