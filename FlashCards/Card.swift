//
//  Card.swift
//  FlashCards
//
//  Created by Jacob Hoffman on 12/30/20.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th doctor in Dr Who?", answer: "Jodie Whittaker")
    }
}
