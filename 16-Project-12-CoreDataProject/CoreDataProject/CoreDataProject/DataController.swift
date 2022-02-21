//
//  DataController.swift
//  CoreDataProject
//
//  Created by Matt X on 2/18/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy
                .mergeByPropertyObjectTrump
        }
    }
}
