//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 29/12/21.
//

import Foundation


struct EmojiTheme{
    let vehicleEmojis = ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂"]

    let animalsEmojis = ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"]
    
    let halloweenEmojis = ["👻","🎃","🧟","🕷","🕸", "🦇", "🪓", "🔪", "⛓", "⚰️"]

    let suitesEmojis = ["♠️","♣️","♥️","♦️"]
    
    let sportsEmojis = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥇", "🏆"]
    
    let foodEmojis = ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"]
    
    let facesEmojis = ["😃","😂","😍","🙃","😇","😎","🤓","🤩",
                       "🤬","🥶","🤢","🤠","😷","🤕","😱","😜",
                       "🥵","🤡","💩","🥳"]
    
    
    private(set) var currentTheme: EmojiThemeModel!
    
    
    init(theme: EmojiThemeEnum){
        self.currentTheme = self.getTheme(theme)
    }
    
    
    
    func getTheme(_ theme: EmojiThemeEnum) -> EmojiThemeModel{
        
        switch theme{
            
        case .vehicle:
            return EmojiThemeModel(id: UUID().uuidString, name: "Vehicle", emojis: self.vehicleEmojis, hexColor: "#12c233", numberOfPairOfCards: 5)
            
        case .halloween:
            return EmojiThemeModel(id: UUID().uuidString, name: "Halloween", emojis: self.halloweenEmojis, hexColor: "#f1548d", numberOfPairOfCards: 5)
        case .suites:
            return EmojiThemeModel(id: UUID().uuidString, name: "Suites", emojis: self.suitesEmojis, hexColor: "#3091d6", numberOfPairOfCards: 5)
        case .sports:
            return EmojiThemeModel(id: UUID().uuidString, name: "Sports", emojis: self.vehicleEmojis, hexColor: "#ff6663", numberOfPairOfCards: 5)
        case .food:
            return EmojiThemeModel(id: UUID().uuidString, name: "Food", emojis: self.foodEmojis, hexColor: "#a15ebb", numberOfPairOfCards: 5)
        case .faces:
            return EmojiThemeModel(id: UUID().uuidString, name: "Faces", emojis: self.facesEmojis, hexColor: "#fba72c", numberOfPairOfCards: 5)
        }
        
    }
    
    enum EmojiThemeEnum: CaseIterable{
        
        case vehicle
        case halloween
        case suites
        case sports
        case food
        case faces
        
        
    }
    
    


    
}


