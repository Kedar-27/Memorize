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
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90),
                            endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90 ))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90),
                            endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90 ))
                        
                    }
                }
                .foregroundColor(color).opacity(DrawingConstants.pieOpacity)
                .padding(DrawingConstants.piePadding)


                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(font(in: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp, color: color)
            
            
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) /  DrawingConstants.fontSize / DrawingConstants.fontScale
    }

    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
        static let fontSize: CGFloat = 32
        static let piePadding: CGFloat = 5
        static let pieOpacity = 0.4
    }
}
