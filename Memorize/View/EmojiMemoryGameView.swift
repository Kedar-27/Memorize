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
    @Namespace private var dealingNamespace
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom) {
                VStack {
                    gameBody
                    HStack {
                        restart
                        Spacer()
                        self.shuffleButton
                    }
                    .padding(.horizontal)
                }
                deckBody
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
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .zIndex(zIndex(of: card))
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.choose(card)
                        }
                        
                        
                    }
            }
        }
        
        
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                CardView(card: card, color: self.viewModel.currentTheme)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition
                                    .asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // "deal" cards
            for card in self.viewModel.cards{
                
                withAnimation(dealAnimation(for: card)) {
                    
                    //Not needed, since using matchedGeometryEffect
                    //  DispatchQueue.main.async {
                    self.deal(card)
                    
                    // }
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
                viewModel.restart()
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
    
    private func dealAnimation(for card: MemoryGame<String>.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * ( CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: MemoryGame<String>.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
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
