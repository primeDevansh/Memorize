//
//  ContentView.swift
//  Memorize
//
//  Created by Devansh Rastogi on 23/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var CardCount: Int = 4
    let emojis: Array<String> = ["✈️", "🚗", "🚀", "🚙", "🚎", "🚛", "🏎", "🛫", "🚕", "🚐", "⛴", "🚝", "🚟"]
    var body: some View {
        VStack {
            ScrollView() {
                cards
            }
            Spacer()
            HStack {
                cardRemover
                Spacer()
                cardAdder
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<CardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardAdder: some View {
        cardCountAdjust(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var cardRemover: some View {
        cardCountAdjust(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    func cardCountAdjust(by offset: Int, symbol: String) -> some View {
        Button(action: {
            CardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(CardCount + offset < 1 || CardCount + offset > emojis.count )
    }
}

struct CardView: View {
    let content: String //no default => we can let it be 'let'
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
