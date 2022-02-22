//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        List {
            Section("Status") {
                user.isActive ? (
                    Text("Currently online")
                        .foregroundColor(.green)
                ) : (
                    Text("Currently offline")
                        .foregroundColor(.red)
                )
            }
            
            Section("Company") {
                Text(user.company)
            }
            
            Section("Email") {
                Text(user.email)
            }
            
            Section("Address") {
                Text(user.address)
            }
            
            Section("About") {
                NavigationLink {
                    UserAboutText(user: user)
                } label: {
                    Text(user.about)
                        .lineLimit(2)
                }
            }
            
            Section("Date Registered") {
                Text(user.registered.formatted(
                    date: .abbreviated,
                    time: .shortened))
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
            
            Section("Tags") {
                ForEach(user.tags, id: \.hashValue) { tag in
                    Text(tag)
                }
            }
        }
        .navigationTitle("\(user.name), \(user.age)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(user: User.sampleUser)
        }
    }
}
