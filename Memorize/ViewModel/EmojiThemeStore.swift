//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 21/01/22.
//

import Foundation


struct EmojiThemeModel: Identifiable, Codable, Hashable{
    let id: String
    let name: String
    let emojis: [String]
    let hexColor: String
    let numberOfPairOfCards: Int

}



class EmojiThemeStore: ObservableObject {
    
    // MARK: - Properties
    @Published var themesList = [EmojiThemeModel]() {
        didSet {
           // storeInUserDefaults()
        }
    }
    
    // MARK: - Initializer
    init() {
       // restoreFromUserDefaults()
        if themesList.isEmpty {
            insertTheme(named: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Animals", emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "COVID", emojis: "💉🦠😷🤧🤒",color: "",numberOfPairOfCards: 2)
            insertTheme(named: "Faces", emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠",color: "",numberOfPairOfCards: 2)
        }
    }
    

    // MARK: - Intent
    
    func palette(at index: Int) -> EmojiThemeModel {
        let safeIndex = min(max(index, 0), themesList.count - 1)
        return themesList[safeIndex]
    }
    
    @discardableResult
    func removePalette(at index: Int) -> Int {
        if themesList.count > 1, themesList.indices.contains(index) {
            themesList.remove(at: index)
        }
        return index % themesList.count
    }
    
    func insertTheme(named name: String, emojis: String? = nil, color: String, numberOfPairOfCards: Int , at index: Int = 0) {
        let unique = UUID().uuidString
        let theme = EmojiThemeModel(id: unique, name: name, emojis: Array(arrayLiteral: emojis ?? ""), hexColor: color, numberOfPairOfCards: numberOfPairOfCards)
        let safeIndex = min(max(index, 0), themesList.count)
        themesList.insert(theme, at: safeIndex)
    }

    
    
    

}
