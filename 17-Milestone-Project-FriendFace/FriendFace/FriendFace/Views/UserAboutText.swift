//
//  UserAboutText.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct UserAboutText: View {
    let cachedUser: CachedUser
    
    var body: some View {
        Text(cachedUser.wrappedAbout)
            .padding()
            .navigationTitle("About \(cachedUser.wrappedName)")
            .navigationBarTitleDisplayMode(.inline)
    }
}
