//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Thiago Farias on 01/04/2024.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: Array<Card>
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
