//
//  ContentView.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var cachedUsers: FetchedResults<CachedUser>
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(cachedUsers) { cachedUser in
                    NavigationLink {
                        UserDetailView(cachedUser: cachedUser)
                    } label : {
                        HStack {
                            Circle()
                                .fill(
                                    cachedUser.isActive ? StatusColor.online : StatusColor.offline
                                )
                                .frame(width: 20, height: 20)
                            
                            Text(cachedUser.wrappedName)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
        .onAppear {
            // Comment this line out to see that the data is saved to Core Data
            userViewModel.fetchUsers(context: context)
        }
    }
}
