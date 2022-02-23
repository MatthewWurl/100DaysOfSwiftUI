//
//  User.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let sampleUser = User(
        id: UUID(),
        isActive: true,
        name: "Sample User",
        age: 33,
        company: "Sample Co.",
        email: "sample_user@sample.com",
        address: "123 Main Street, New York, New York, 11111",
        about: "Sample about...",
        registered: Date.now,
        tags: ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7"],
        friends: [
            Friend(id: UUID(), name: "Friend One"),
            Friend(id: UUID(), name: "Friend Two"),
            Friend(id: UUID(), name: "Friend Three")
        ]
    )
}
