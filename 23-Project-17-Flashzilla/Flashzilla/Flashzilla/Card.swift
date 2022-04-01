//
//  Card.swift
//  Flashzilla
//
//  Created by Matt X on 3/21/22.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "What is the capital of Sweden?",
                              answer: "Stockholm")
}
