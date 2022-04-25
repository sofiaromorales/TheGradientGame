//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI

struct CircleProgressBarView: View {
    
    let evaluationAccuracyPercentage: Double
    
    @State var circleProgress: CGFloat = 0.0

    var body: some View {
        
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), style: StrokeStyle(lineWidth: 20))
            Circle()
                .trim(from: 0, to: circleProgress)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .shadow(
                    color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 3, x: 0, y: 3
                )
                
//            Circle()
//                .trim(from: 0, to: CGFloat(((evaluationAccuracyPercentage - 50) * 2) / 100))
//                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
//                .fill(AngularGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
//                .animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
            Text("\((evaluationAccuracyPercentage - 50) * 2 > 0 ? String(format: "%.0f", (evaluationAccuracyPercentage - 50) * 2) : String(0))%")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .onAppear() {
            startLoading()
        }
        
    }
    
    func startLoading() {
        print("start")
            _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                withAnimation() {
                    self.circleProgress += 0.01
                    if self.circleProgress >= CGFloat(((evaluationAccuracyPercentage - 50) * 2) / 100) {
                        timer.invalidate()
                    }
                }
            }
        }
    
}
