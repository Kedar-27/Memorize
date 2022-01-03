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
    @State private var dealtCards = Set<Int>()
    
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center) {
                gameBody
                
                HStack{
                    restart
                    Spacer()
                    shuffleButton
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
    
    var gameBody: some View{
        AspectVGrid(items: viewModel.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if  self.isUndealt(card) || (card.isMatched && !card.isFaceUp ){
                //Rectangle().opacity(0) // Can be replaced with Color.clear
                Color.clear
            }
            else {
                CardView(card: card, color: viewModel.currentTheme)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 1)))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.choose(card)
                        }
                        
                        
                    }
            }
        }
        .onAppear {
            
            DispatchQueue.main.async {
                for card in viewModel.cards{
                    self.deal(card)
                }
                
            }
        }
        
        
    }
    
    var shuffleButton: some View{
        
        Button("Shuffle"){
            
            withAnimation(.easeIn(duration: 1)) {
                self.viewModel.shuffleCards()
            }
            
            
            
        }
        
        
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                self.dealtCards = []
                // game.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
    
    
    // MARK: - Methods
    
    private func deal(_ card: MemoryGame<String>.Card){
        self.dealtCards.insert(card.id)
        
    }
    
    private func isUndealt(_ card: MemoryGame<String>.Card) -> Bool{
        !self.dealtCards.contains(card.id)
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
