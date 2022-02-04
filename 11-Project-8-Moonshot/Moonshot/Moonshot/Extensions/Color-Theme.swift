//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Matt X on 2/1/22.
//

import SwiftUI

// These colors can be used everywhere a ShapeStyle is expected
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
