//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Matt X on 3/31/22.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode(Set<String>.self, from: data)
            resorts = decoded
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        
        resorts.insert(resort.id)
        
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        
        resorts.remove(resort.id)
        
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(
                to: savePath,
                options: [.atomic, .completeFileProtection]
            )
        } catch {
            print("Failed to save resorts.")
        }
    }
}
