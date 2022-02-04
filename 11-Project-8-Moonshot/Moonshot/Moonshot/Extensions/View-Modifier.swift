//
//  View-Modifier.swift
//  Moonshot
//
//  Created by Matt X on 2/3/22.
//

import SwiftUI

struct SectionHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

extension View {
    func sectionHeadingStyle() -> some View {
        modifier(SectionHeadingStyle())
    }
}
