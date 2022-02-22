//
//  UserAboutText.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct UserAboutText: View {
    let user: User
    
    var body: some View {
        Text(user.about)
            .padding()
            .navigationTitle("About \(user.name)")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserAboutText_Previews: PreviewProvider {
    static var previews: some View {
        UserAboutText(user: User.sampleUser)
    }
}
