//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Thiago Farias on 01/04/2024.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content : CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        print("chose \(card)")
        let cardIndex = getIndex(of: card)
        cards[cardIndex].isFaceUp.toggle()
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func getIndex(of card: Card) -> Int {
        for index in cards.indices {
            if (cards[index].id == card.id) {
                return index
            }
        }
        return 0 // FIXME: bogus!
    }
    
    struct Card : Equatable, Identifiable {
               
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
        }
        
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
}
