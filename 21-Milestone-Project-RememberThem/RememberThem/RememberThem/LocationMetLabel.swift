//
//  LocationMetLabel.swift
//  RememberThem
//
//  Created by Matt X on 3/11/22.
//

import SwiftUI

struct LocationMetLabel: View {
    enum LocationMetStatus {
        case known, unknown
    }
    
    let title: String
    let status: LocationMetStatus
    
    var systemImage: String {
        status == .known ? "map" : "questionmark"
    }
    
    var body: some View {
        Label(title, systemImage: systemImage)
    }
}

struct LocationMetLabel_Previews: PreviewProvider {
    static var previews: some View {
        LocationMetLabel(title: "Here's where you met them", status: .known)
    }
}
