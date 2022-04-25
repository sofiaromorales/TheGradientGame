//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI
import AVFoundation

private func createColor(_ red: Double, _ green: CGFloat, _ blue: CGFloat) -> Color {
     Color(red: red / 255, green: green / 255, blue: blue / 255)
}

private let startGradientColor = createColor(255, 200, 255)
private let endGradientColor = createColor(240, 167, 175)
private let gradient = LinearGradient(colors: [startGradientColor, endGradientColor], startPoint: .top, endPoint: .bottom)
private let maskGradient = LinearGradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0.8)], startPoint: .top, endPoint: .bottom)
private let gradients = [
    LinearGradient(colors: [Color(#colorLiteral(red: 0.6235645413, green: 0.9680026174, blue: 0.6224516034, alpha: 1)), Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))], startPoint: .top, endPoint: .bottom),
    LinearGradient(colors: [Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), Color(#colorLiteral(red: 0.9095132947, green: 0.7921276348, blue: 0.8620900819, alpha: 1))], startPoint: .top, endPoint: .bottom),
    LinearGradient(colors: [Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))], startPoint: .top, endPoint: .bottom),
    LinearGradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.4897090127, green: 0.5124260644, blue: 0.9697592854, alpha: 1))], startPoint: .top, endPoint: .bottom),
    LinearGradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.6513687763, green: 0.9750260711, blue: 0.8576376935, alpha: 1))], startPoint: .top, endPoint: .bottom)
]

private let maxSize: CGFloat = UIScreen.main.bounds.width < UIScreen.main.bounds.height ? UIScreen.main.bounds.width / 2.5 : UIScreen.main.bounds.height / 3
private let minSize : CGFloat = 40
private let inhaleTime: Double = 3
private let exhaleTime: Double = 4
private let pauseTime: Double = 0.5

private let ghostMaxSize = maxSize * 0.99
private let ghostMinSize = maxSize * 0.98

struct BreathAnimation: View {
    
    let delayTime: Double
    
    @State private var size = minSize
    @State private var inhaling = false
    @State private var ghostSize = ghostMaxSize
    @State private var ghostBlur: Double = 0
    @State private var ghostOpacity: Double = 0
    @State private var gradient: LinearGradient! = gradients.randomElement()
    
    var body: some View {
        
        let rotateWhenInhaling: Angle = inhaling ? .degrees(60) : .degrees(-120)
        
        ZStack {
            ZStack {
                Petals(isMask: false, gradient: gradient, size: ghostSize, inhaling: inhaling)
                    .blur(radius: ghostBlur)
                    .opacity(ghostOpacity)
                Petals(isMask: true, gradient: gradient, size: size, inhaling: inhaling)
                Petals(isMask: false, gradient: gradient, size: size, inhaling: inhaling)
            }
            .rotationEffect(rotateWhenInhaling)
            .onAppear {
                performBreatheAnimation(delayTime: delayTime)
            }
            
        }
        
    }
    
    func performBreatheAnimation(delayTime: Double) {
        withAnimation(.easeInOut(duration: inhaleTime).delay(delayTime).repeatForever()) {
            inhaling = true
            size = maxSize
        }
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTime, repeats: false) { timer in
            ghostSize = ghostMaxSize
            ghostBlur = 0
            ghostOpacity = 0.8
            Timer.scheduledTimer(withTimeInterval: exhaleTime * 0.2, repeats: false) { time in
                withAnimation(.easeOut(duration: exhaleTime * 0.6).repeatForever()) {
                    ghostOpacity = 0
                    ghostBlur = 10
                }
            }
            withAnimation(.easeInOut(duration: exhaleTime).delay(delayTime).repeatForever()) {
                inhaling = false
                size = minSize
            }
        }
    }
}

struct Petals: View {
    
    let isMask: Bool
    let gradient: LinearGradient
    let size: CGFloat
    let inhaling: Bool
    
    var body: some View {
        
        let petalsGradient = isMask ? maskGradient : gradient
        
        ZStack {
            ForEach(0..<6) { index in
                petalsGradient
                    .mask (
                        Circle()
                            .frame(width: size, height: size)
                            .offset(x: inhaling ? size * 0.5 : 0)
                            .rotationEffect(.degrees(Double(60 * index)))
                    )
                    .blendMode(isMask ? .normal : .screen)
            }
        }
        
    }
    
}

struct IntroView: View {
    
    @State private var animateGradient = true
    @Binding var show: Bool
    @State var player: AVAudioPlayer?
    
    var body: some View {
        
                VStack {
                    Spacer()
                    Text("Welcome to the Gradient Game")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.top)
                        .zIndex(1)
                    Spacer()
                    ZStack {
                        BreathAnimation(delayTime: 0)
                        BreathAnimation(delayTime: exhaleTime / 2)
                            .opacity(0.5)
                        BreathAnimation(delayTime: exhaleTime / 4)
                            .opacity(0.2)
                    }
                    .zIndex(0)
                    Spacer()
                    Button {
                        show.toggle()
                    } label: {
                        Spacer()
                        Text("Start!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding()
                        Spacer()
                    }
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .padding()
                    .zIndex(1)
                }
                .background(Color.black)
        
    
    }
    
    func playTapMusic() {
        do {
            player = try AVAudioPlayer(contentsOf: arrayOfSounds[1].getURL(type: "wav")!)
            player?.prepareToPlay()
            player?.play()
            
        } catch {
            print("Error")
        }
    }
    
}
