//
//  ContentView.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 27/12/21.
//

import SwiftUI

struct ContentView: View {
    
    // Step 2: Add @ObservedObject to listen to changes.
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView{

            VStack(alignment: .center) {
                ScrollView {
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach( viewModel.cards) { card in
                            CardView(card: card, currentThemeColor: viewModel.currentTheme )
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    self.viewModel.choose(card)
                                }
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

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    let currentThemeColor: Color
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 25)
        
        ZStack {
            
            if card.isFaceUp{
                
                shape.fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3, antialiased: true)
                    .foregroundColor(currentThemeColor)
                Text(card.content).font(.largeTitle)
            }else if card.isMatched{
                shape.opacity(0)
            
            }else{
                shape
                    .fill()
                    .foregroundColor(currentThemeColor)
                
            }
            
            
            
        }
        
        
    }
}









struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel =  EmojiMemoryGame()
        ContentView(viewModel: viewModel)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portraitUpsideDown)
        ContentView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
