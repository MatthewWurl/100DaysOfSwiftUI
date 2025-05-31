//
//  Order.swift
//  CupcakeCorner
//
//  Created by Matt X on 2/11/22.
//

import SwiftUI

class OrderObject: ObservableObject {
    @Published var order: Order = Order()
}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        let addressProperties = [name, streetAddress, city, zip]
        
        for addressProperty in addressProperties {
            if addressProperty.isPureWhitespace() { return false }
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        
        // Complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

extension String {
    func isPureWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
