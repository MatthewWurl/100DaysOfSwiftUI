//
//  Prospect.swift
//  HotProspects
//
//  Created by Matt X on 3/15/22.
//

import SwiftUI

class Prospect: Codable, Identifiable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateCreated = Date.now
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPersons")
    
    init() {
        // Switch from UserDefaults to JSON...
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        // Switch from UserDefaults to JSON...
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(
                to: savePath,
                options: [.atomic, .completeFileProtection]
            )
        } catch {
            print("Unable to save data...")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
