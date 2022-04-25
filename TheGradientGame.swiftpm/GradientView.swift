//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI

struct GradientView: View {
    
    let accuracyPercentage: Double?
    let colors: [Color]
    let isGameCompleted: Bool
    
    var borderCompletitionWidth: CGFloat {
        if let accurateP = accuracyPercentage {
            return accurateP > 80
            ?  accurateP - 75
            : 5
        }
        return 0
    }
    
    var borderColor: Color {
        if let accurateP = accuracyPercentage {
            return accurateP > 80
            ?  Color.green
            : accurateP > 60
            ? Color.orange
            : Color.black
        }
        return Color.black
    }
    
    var body: some View {
        
        HStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: isGameCompleted ? 0 : 10)
                        .foregroundColor(borderColor)
                        .animation(.easeIn(duration: 1), value: borderCompletitionWidth)
                    Text("You made it! 🎉")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .opacity(isGameCompleted ? 1 : 0)
                        .padding(.vertical)
                }
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: colors),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: isGameCompleted ? 0 : .infinity, height: isGameCompleted ? 1 : .infinity, alignment: .center)
                    .padding(borderCompletitionWidth)
                    .animation(.easeIn(duration: 1), value: borderCompletitionWidth)
            }
        }
        
    }
    
}
