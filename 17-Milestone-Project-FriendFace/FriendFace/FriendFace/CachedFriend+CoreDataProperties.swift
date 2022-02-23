//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Matt X on 2/22/22.
//
//

import Foundation
import CoreData


extension CachedFriend {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
}

extension CachedFriend : Identifiable {
    
}
