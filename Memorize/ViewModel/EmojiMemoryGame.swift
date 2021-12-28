//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 28/12/21.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject{
    // MARK: - Properties
    var cards: [MemoryGame<String>.Card]{
        self.model.cards
    }

    var currentTheme: Color{
        return Color(hex: self.themeModel.currentTheme.hexColor)
        
    }
    
    var score: Int{
        self.model.score
    }

    
    
    // Step 1: Add @Published to publish changes.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createNewGame()

    @Published private var themeModel: EmojiTheme = EmojiTheme(theme: EmojiTheme.EmojiThemeEnum.allCases.randomElement() ?? .vehicle)
    
    
    // MARK: - Methods
    static func createMemoryGame(theme: EmojiTheme.EmojiThemeModel) -> MemoryGame<String> {
      return  MemoryGame<String>(numberOfPairsOfCards: 4) { index in
          return theme.emojis[index]
        }

        
    }
    

    
    
    // MARK: - Intent(s)
    
    static func createNewGame(theme: EmojiTheme.EmojiThemeEnum = EmojiTheme.EmojiThemeEnum.allCases.randomElement() ?? .vehicle) -> MemoryGame<String>{
        let theme = EmojiTheme(theme: theme).currentTheme!
        
        return self.createMemoryGame(theme: theme)
    }
    
    
    func createNewGame(){
        self.themeModel = EmojiTheme(theme: EmojiTheme.EmojiThemeEnum.allCases.randomElement() ?? .vehicle)
        self.model =  EmojiMemoryGame.createMemoryGame(theme: self.themeModel.currentTheme!)
    }

    
    
    
    func choose(_ card: MemoryGame<String>.Card){
        self.model.choose(card)
    }
    
    
}

