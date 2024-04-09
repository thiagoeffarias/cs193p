//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Thiago Farias on 01/04/2024.
//

import SwiftUI

// ViewModel
class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻","🐸","🦊","🦉", "🤖", "😺", "🪲", "🦆", "🍏", "🥦", "🍕", "🚒","🍑","🍉", "🛼", "🥎", "☎️" ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffleCards() {
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

}
