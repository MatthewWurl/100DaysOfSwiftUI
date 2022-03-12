//
//  Person.swift
//  RememberThem
//
//  Created by Matt X on 3/10/22.
//

import MapKit
import SwiftUI

struct Person: Codable, Comparable, Identifiable {
    var id = UUID()
    let name: String
    let jpegData: Data
    // Optional... User may not want to use location information...
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    var image: Image? {
        let uiImage = UIImage(data: jpegData)
        
        guard let uiImage = uiImage else { return nil }
        
        return Image(uiImage: uiImage)
    }
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude else { return nil }
        guard let longitude = longitude else { return nil }
        
        return .init(latitude: latitude, longitude: longitude)
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
