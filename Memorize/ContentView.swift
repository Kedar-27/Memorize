//
//  ContentView.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 27/12/21.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂"]
    
    @State var emojiCount = 10
    
    var body: some View {
        
        
        VStack {
//            HStack {
//                ForEach(emojis[0..<emojiCount],id: \.self) { emoji in
//                    CardView(content: emoji)
//                }
//
//            }
            
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[0..<emojiCount],id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                    
                }
            }
            
            
            Spacer()
            
            HStack {
                Button {
                    if emojiCount > 0{
                        emojiCount -= 1
                    }

                } label: {
                    Image(systemName: "minus.circle")
                    
                }
                
                Spacer()
                
                Button {
                    if emojiCount < emojis.count {
                        emojiCount += 1
                    }
                    
                } label: {
                    Image(systemName: "plus.circle")
                    
                }
                
                
            }
            
            
        }
        .font(.largeTitle)
        .padding(.all, 15.0)
        
    }
}

struct CardView: View {
    
    var content: String
    
    
    @State var isFaceUp: Bool = false
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 25)
        
        ZStack {
            
            if self.isFaceUp{
                
                shape.fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3, antialiased: true)
                Text(content).font(.largeTitle)
                
            }else{
                shape
                    .fill()
                    .foregroundColor(.red)
                
            }
            
            
            
        }
        
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
        
        
        
        
        
        
        
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portraitUpsideDown)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
