//
//  ViewModel.swift
//  RememberThem
//
//  Created by Matt X on 3/10/22.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var people: [Person]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPersons")
    
    init() {
        // Get data from disk
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data).sorted()
        } catch {
            people = []
        }
    }
    
    func save() {
        // Save data to disk
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(
                to: savePath,
                options: [.atomic, .completeFileProtection]
            )
        } catch {
            print("Unable to save data.")
        }
    }
    
    func addPerson(_ person: Person) {
        people.append(person)
        save()
    }
    
    func removePerson(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }
}
