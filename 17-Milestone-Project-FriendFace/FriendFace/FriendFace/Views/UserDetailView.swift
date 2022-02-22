//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var sortedFriends: [Friend] {
        user.friends.sorted { $0.name < $1.name }
    }
    
    var statusString: String {
        user.isActive ? "Currently online" : "Currently offline"
    }
    
    var statusColor: Color {
        user.isActive ? StatusColor.online : StatusColor.offline
    }
    
    var body: some View {
        List {
            Section("Status") {
                Text(statusString)
                    .foregroundColor(statusColor)
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
                ForEach(sortedFriends) { friend in
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
