//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 27/12/21.
//

import Foundation




struct MemoryGame<CardContent: Equatable>{
    
    private(set) var cards: [Card]
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    private(set) var score: Int = 0
    
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        self.cards = []
        
        
        for index in 0..<numberOfPairsOfCards{
            let cardContent: CardContent = createCardContent(index)
            
            self.cards.append(Card( id: index*2, content: cardContent))
            self.cards.append(Card( id: index*2+1, content: cardContent))
        }
        
        self.cards.shuffle()
        
    }
    
    
    mutating func choose(_ card: Card){
        guard let chosenCardIndex = self.cards.firstIndex(where: { $0 == card}), !self.cards[chosenCardIndex].isFaceUp , !self.cards[chosenCardIndex].isMatched else{return}
        
        
        
        if let potentialIndex = self.indexOfOneAndOnlyFaceUpCard{
            
            if self.cards[potentialIndex].content == self.cards[chosenCardIndex].content{
              // Its a match!
                self.cards[potentialIndex].isMatched = true
                self.cards[chosenCardIndex].isMatched = true
                self.updateScore(2)
            }else{
                self.updateScore(-1)
            }
            
            self.indexOfOneAndOnlyFaceUpCard = nil
        }else{
            // No card selected
            
            for index in self.cards.indices{
                self.cards[index].isFaceUp = false
            }
            
            self.indexOfOneAndOnlyFaceUpCard = chosenCardIndex
        }
        
        
        
        
        self.cards[chosenCardIndex].isFaceUp.toggle()
    }
    
    
    mutating func updateScore(_ newScore: Int){
        self.score = self.score + newScore
    }
    

    
    struct Card: Identifiable,Equatable{
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }
        
        var id: Int
        var isMatched: Bool = false
        var isFaceUp: Bool = false
        var content: CardContent
    }
    
    
}
