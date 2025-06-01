//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     dataController.container.viewContext
                )
        }
    }
}
