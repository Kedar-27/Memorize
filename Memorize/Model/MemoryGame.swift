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
            
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }

        
        var isFaceUp = false{
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false{
            didSet {
                stopUsingBonusTime()
            }
        }
        let id: Int
        let content: CardContent
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    
}
