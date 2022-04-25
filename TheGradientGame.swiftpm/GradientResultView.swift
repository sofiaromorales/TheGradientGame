//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI
import AVFoundation

struct GradientResultView: View {
    
    let colors: [Color]
    let isGameCompleted: Bool
    let rgbColors: [RGBColor]
    
    var red1RGB: String {
        String(format: "%.0f", (rgbColors[0].red * 255))
    }
    var green1RGB: String {
        String(format: "%.0f", (rgbColors[0].green * 255))
    }
    var blue1RGB: String {
       String(format: "%.0f", (rgbColors[0].blue * 255))
    }
    
    var red2RGB: String {
        String(format: "%.0f", (rgbColors[1].red * 255))
    }
    var green2RGB: String {
        String(format: "%.0f", (rgbColors[1].green * 255))
    }
    var blue2RGB: String {
       String(format: "%.0f", (rgbColors[1].blue * 255))
    }
    
    @State private var player: AVAudioPlayer?

    @State private var animate = false
    
    func playWinMusic() {
        do {
            player = try AVAudioPlayer(contentsOf: arrayOfSounds[4].getURL(type: "wav")!)
            player?.prepareToPlay()
            player?.play()
            
        } catch {
            print("Error")
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                if (!isGameCompleted) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        VStack {
                            ZStack {
                                Text("MATCH THIS GRADIENT")
                                    .foregroundColor(.black)
                                    .fontWeight(.light)
                                    .font(.footnote)
                                    .padding(10)
                                    
                            }
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                           Spacer()
                        }
                        .padding(10)
                       
                    }
                    
                } else {
                    LinearGradient(
                        gradient: Gradient(colors: colors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .cornerRadius(10)
                        .hueRotation(.degrees(animate ? 60 : 0))
                        .onAppear {
                            playWinMusic()
                            withAnimation(.easeInOut(duration: 10.0).repeatForever(autoreverses: true)) {
                                animate.toggle()
                            }
                        }
                }
                if (isGameCompleted) {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Call to Code")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("WWDC22")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ZStack {
                            gradientStrokeCircle
                            swiftLogo
                            topLeftCircleGlow
                            lensFlare
                        }
                        .frame(height: UIScreen.main.bounds.height / 3)
                        Spacer()
                        HStack {
                            Spacer()
                            HStack {
                                Text("R: \(red1RGB)")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Text("G: \(green1RGB)")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Text("B: \(blue1RGB)")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom)
                            Spacer()
                            HStack {
                                Text("R: \(red2RGB)")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Text("G: \(green2RGB)")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Text("B: \(blue2RGB)")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom)
                            Spacer()
                            
                        }
                        .padding(.bottom)
                    }
                    
                    
                }
            }
        }
    }
    
    private var gradientStrokeCircle: some View {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                Circle()
                    .stroke(lineWidth: 2)
            }
            .hueRotation(.degrees(animate ? 60 : 0))
            .onAppear {
                animation(.easeInOut(duration: 10.0).repeatForever(autoreverses: true), value: isGameCompleted)
            }
            .padding(25)
    }
    
    private var topLeftCircleGlow: some View {
        Circle()
            .foregroundColor(.white)
            .padding(25)
            .blur(radius: 20)
            .opacity(0.5)
            .mask {
                AngularGradient(colors: [.clear, .white, .clear, .clear, .clear],
                                center: .center, angle: .degrees(135))
                    .mask {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                            Circle()
                                .foregroundColor(.black)
                                .padding(25)
                        }
                        .compositingGroup()
                        .luminanceToAlpha()
                    }
            }
    }

    
    private var swiftLogo: some View {
        Image(systemName: "swift")
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .opacity(0.3)
            .padding(80)
        
    }

    private var swiftLogoBottomGlow: some View {
        swiftLogo
            .foregroundColor(.clear)
            .overlay {
                LinearGradient(colors: [Color(red: 149/255, green: 196/255, blue: 218/255),
                                        Color(red: 64/255, green: 116/255, blue: 163/255),
                                        .white,
                                        Color(red: 64/255, green: 116/255, blue: 163/255),
                                        Color(red: 64/255, green: 116/255, blue: 163/255),
                                        Color(red: 64/255, green: 116/255, blue: 163/255),
                                        Color(red: 64/255, green: 116/255, blue: 163/255),
                                        Color(red: 2/255, green: 5/255, blue: 20/255),
                                        Color(red: 2/255, green: 5/255, blue: 20/255)],
                               startPoint: .bottomTrailing, endPoint: .topLeading)
                    .mask {
                        swiftLogo
                    }
            }
            .padding(110)
            .offset(x: 1.5, y: 1.5)
    }

    private var swiftLogoTop: some View {
        swiftLogo
            .foregroundColor(.clear)
            .overlay {
                LinearGradient(
                    colors: colors,
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                )
                    .mask {
                        swiftLogo
                            .background(Color.red)
                        
                    }
            }
            .hueRotation(.degrees(animate ? 60 : 0))
            .onAppear {
                animation(.easeInOut(duration: 10.0).repeatForever(autoreverses: true), value: isGameCompleted)
            }
            .padding(110)
    }
    
    private var lensFlareLine: some View {
        LinearGradient(stops: [.init(color: .clear, location: 0.49),
                               .init(color: .white, location: 0.5),
                               .init(color: .clear, location: 0.51)],
                       startPoint: .top, endPoint: .bottom)
            .mask {
                RadialGradient(colors: [.white, .white, .white, .clear, .clear],
                               center: .center, startRadius: 0, endRadius: 30)
            }
            .blur(radius: 1)
            .opacity(0.25)
    }
    
    private var lensFlare: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .blur(radius: 50)
                .opacity(0.5)
            lensFlareLine
            lensFlareLine
                .scaleEffect(0.3)
                .rotationEffect(.degrees(-40))
                .blur(radius: 1)
            lensFlareLine
                .scaleEffect(0.25)
                .rotationEffect(.degrees(85))
                .blur(radius: 1)
            lensFlareLine
                .scaleEffect(0.2)
                .rotationEffect(.degrees(-10))
            lensFlareLine
                .scaleEffect(0.15)
                .rotationEffect(.degrees(-50))
            Circle()
                .foregroundColor(.white)
                .frame(width: 2, height: 2)
                .blur(radius: 1)
                .shadow(color: .white, radius: 2, x: 0, y: 0)
                .shadow(color: .white, radius: 2, x: 0, y: 0)
                .shadow(color: .white, radius: 2, x: 0, y: 0)
        }
        .offset(x: -82, y: -64)
    }
}

struct FlatGlassView: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(14)
        } else {
            // Fallback on earlier versions
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(14)
        }
    }
}
