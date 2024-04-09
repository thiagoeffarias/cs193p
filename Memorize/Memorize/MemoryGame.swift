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
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter {index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        print("chosen \(card)")
        if let chosenIndex = cards.firstIndex(where: { cardToCheck in
            cardToCheck.id == card.id
        }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
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

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
