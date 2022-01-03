//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 27/12/21.
//

import Foundation




struct MemoryGame<CardContent: Equatable>{
    
    private(set) var cards: [Card]
    private(set) var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue) }) }
    }
    
    
    
    
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        self.cards = []
        
        
        for index in 0..<numberOfPairsOfCards{
            let cardContent: CardContent = createCardContent(index)
            
            self.cards.append(Card( id: index*2, content: cardContent))
            self.cards.append(Card( id: index*2+1, content: cardContent))
        }
        
        self.shuffleCards()
        
    }
    
    
    mutating func choose(_ card: Card){
        guard let chosenCardIndex = self.cards.firstIndex(where: { $0 == card}), !self.cards[chosenCardIndex].isFaceUp , !self.cards[chosenCardIndex].isMatched else{return}
        
        
        
        if let potentialIndex = self.indexOfTheOneAndOnlyFaceUpCard{
            
            if self.cards[potentialIndex].content == self.cards[chosenCardIndex].content{
              // Its a match!
                self.cards[potentialIndex].isMatched = true
                self.cards[chosenCardIndex].isMatched = true
                self.updateScore(2)
            }else{
                self.updateScore(-1)
            }
            
            self.cards[chosenCardIndex].isFaceUp = true
        }else{
            // No card selected
            self.indexOfTheOneAndOnlyFaceUpCard = chosenCardIndex
        }
        
        
        
        
        
    }
    
    
    mutating func updateScore(_ newScore: Int){
        self.score = self.score + newScore
    }
    
    
    mutating func shuffleCards(){
        self.cards.shuffle()
    }

    
    struct Card: Identifiable,Equatable{
        
        let id: Int
        var isMatched = false
        var isFaceUp = false
        let content: CardContent
        
        
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }

    }
    
    
}
