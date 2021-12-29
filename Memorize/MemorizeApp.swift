//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 27/12/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let viewModel = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: viewModel)
        }
    }
}
