//
//  CardView.swift
//  Memorize
//
//  Created by Kedar Sukerkar on 29/12/21.
//

import SwiftUI

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    let color: Color
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius:  DrawingConstants.cornerRadius)
        
        GeometryReader { geometry in
            ZStack {
                
                if card.isFaceUp{
                    
                    shape.fill()
                        .foregroundColor(.white)
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth, antialiased: true)
                        .foregroundColor(color)
                    Pie(startAngle: Angle(degrees:0-90), endAngle: Angle(degrees:110-90), clockwise: false)
                        .foregroundColor(color).opacity(DrawingConstants.pieOpacity)
                        .padding(DrawingConstants.piePadding)
                    Text(card.content)
                        .font(font(in: geometry.size))
                }else if card.isMatched{
                    shape.opacity(0)
                    
                }else{
                    shape
                        .fill()
                        .foregroundColor(color)
                    
                }
                
                
                
            }
        }
        
        
        
        
        
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
        static let piePadding: CGFloat = 5
        static let pieOpacity = 0.4
    }
}
