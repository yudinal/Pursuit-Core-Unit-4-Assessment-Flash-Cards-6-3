//
//  FlashCard.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

//struct FlashCards: Codable & Equatable {
//    let cardListType: String
//    let cards: [FlashCard]
//}

struct FlashCard: Codable, Equatable {
        let id: String
        let quizTitle: String
        let facts: [String]
    
    public func presentAllFacts() -> String {
        var fact = String()
        var facts1 = [String]()
        facts.forEach{facts1.append($0.capitalized)}
        fact = facts1.joined(separator: "\n")
        return fact
}
    
}


