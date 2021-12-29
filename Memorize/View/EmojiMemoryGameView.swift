//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 27/12/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // Step 2: Add @ObservedObject to listen to changes.
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center) {
                AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                    if card.isMatched && !card.isFaceUp {
                        Rectangle().opacity(0)
                    }
                    else {
                    CardView(card: card, color: viewModel.currentTheme)
                            .padding(4)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                
            }
            .font(.largeTitle)
            .padding(.all, 15.0)
            .navigationBarTitle("Memorize", displayMode: .inline)
            
            .navigationViewStyle(.stack)
            
            .ignoresSafeArea(edges: .bottom)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Text("Score: \(self.viewModel.score)")
                    
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("New Game") {
                        self.viewModel.createNewGame()
                    }
                    
                }
                
            }
        }
        .navigationViewStyle(.stack)
    }
    
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel =  EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: viewModel)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portraitUpsideDown)
        EmojiMemoryGameView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
