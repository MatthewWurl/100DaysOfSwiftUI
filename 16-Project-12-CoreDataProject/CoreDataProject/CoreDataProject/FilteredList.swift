//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Matt X on 2/20/22.
//

import CoreData
import SwiftUI

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case beginsWithCaseInsensitive = "BEGINSWITH[c]"
    case containsCaseInsensitive = "CONTAINS[c]"
    
    var stringValue: String {
        self.rawValue
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(
        filterKey: String,
        predicate: Predicate,
        filterValue: String,
        sortDescriptors: [NSSortDescriptor],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        let predicate = NSPredicate(format: "%K \(predicate.stringValue) %@", filterKey, filterValue)
        
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: sortDescriptors,
            predicate: predicate
        )
        
        self.content = content
    }
}
