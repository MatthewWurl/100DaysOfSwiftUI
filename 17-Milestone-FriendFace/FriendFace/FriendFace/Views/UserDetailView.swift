//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct UserDetailView: View {
    let cachedUser: CachedUser
    
    var statusString: String {
        cachedUser.isActive ? "Currently online" : "Currently offline"
    }
    
    var statusColor: Color {
        cachedUser.isActive ? StatusColor.online : StatusColor.offline
    }
    
    var userTags: [String] {
        cachedUser.wrappedTags.components(separatedBy: ",")
    }
    
    var friendsArrayCount: Int { cachedUser.friendsArray.count }
    var friendsSetcount: Int { cachedUser.cachedFriends?.count ?? 999 }
    
    init(cachedUser: CachedUser) {
        self.cachedUser = cachedUser
    }
    
    var body: some View {
        List {
            Section("Status") {
                Text(statusString)
                    .foregroundStyle(statusColor)
            }
            
            Section("Company") {
                Text(cachedUser.wrappedCompany)
            }
            
            Section("Email") {
                Text(cachedUser.wrappedEmail)
            }
            
            Section("Address") {
                Text(cachedUser.wrappedAddress)
            }
            
            Section("About") {
                NavigationLink {
                    UserAboutText(cachedUser: cachedUser)
                } label: {
                    Text(cachedUser.wrappedAbout)
                        .lineLimit(2)
                }
            }
            
            Section("Date Registered") {
                Text(cachedUser.wrappedRegistered.formatted(
                    date: .abbreviated,
                    time: .shortened))
            }
            
            Section("Friends") {
                ForEach(cachedUser.friendsArray) { cachedFriend in
                    Text(cachedFriend.wrappedName)
                }
            }
            
            Section("Tags") {
                ForEach(userTags, id: \.hashValue) { tag in
                    Text(tag)
                }
            }
        }
        .navigationTitle("\(cachedUser.wrappedName), \(cachedUser.age)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
