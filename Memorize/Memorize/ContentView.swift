//
//  ContentView.swift
//  Memorize
//
//  Created by Thiago Farias on 27/03/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🐸","🦊","🦉", "🤖", "😺", "🪲", "🦆", "🍏", "🥦", "🍕", "🚒"]
    
    var body: some View {
            ScrollView {
                cards
            }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))], content: {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        })
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack ( content : {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.cardBackground)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        })
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
