//
//  ContentView.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List(userViewModel.users) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    HStack {
                        Circle()
                            .fill(
                                user.isActive ? StatusColor.online : StatusColor.offline
                            )
                            .frame(width: 20, height: 20)
                        
                        Text(user.name)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
