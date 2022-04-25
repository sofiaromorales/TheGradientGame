//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI
import AVFoundation

let GAME_COMPLETITION_PERCENTAGE: CGFloat = 92

struct GameView: View {
    
    @StateObject var game: Game = Game()
    @State private var evalueateGame = false
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var player: AVAudioPlayer?
    
    
    var rgbColors: [Color] = []
    var accuratePercentageColor1: Double {
        ((1 - abs(game.bColor1.red - game.color1.red)) + (1 - abs(game.bColor1.green - game.color1.green)) + (1 - abs(game.bColor1.blue - game.color1.blue))) / 3
    }
    var accuratePercentageColor2: Double {
        ((1 - abs(game.bColor2.red - game.color2.red)) + (1 - abs(game.bColor2.green - game.color2.green)) + (1 - abs(game.bColor2.blue - game.color2.blue))) / 3
    }
    var totalAccuracyPercentage: Double {
        ((accuratePercentageColor1 + accuratePercentageColor2) / 2) * 100
    }
    var isGameCompleted: Bool {
        return ((accuratePercentageColor1 + accuratePercentageColor2) / 2) * 100 > GAME_COMPLETITION_PERCENTAGE
        
    }
    
    func restartGame() {
        evalueateGame = false
        game.regenerate()
    }
    
    var body: some View {
        VStack {
            VStack {
                GradientResultView(
                    colors: [
                        game.bColor1.rgbColor,
                        game.bColor2.rgbColor
                    ],
                    isGameCompleted: isGameCompleted,
                    rgbColors: [game.bColor1, game.bColor2]
                )
                    .padding(.horizontal)
                    .padding(.bottom)
                    .animation(.easeInOut(duration: 1), value: isGameCompleted)
                GradientView(
                    accuracyPercentage: totalAccuracyPercentage,
                    colors: [
                        game.color1.rgbColor,
                        game.color2.rgbColor
                    ],
                    isGameCompleted: isGameCompleted
                )
                    .padding(.horizontal)
                    .frame(height: isGameCompleted ? 0 : .infinity)
                    .animation(.easeInOut(duration: 1), value: isGameCompleted)

            }
                .padding(.bottom)
            VStack {
                if (!isGameCompleted && !evalueateGame) {
                    Spacer()
                    
                    HStack {
                        VStack() {
                            ColorView(
                                color: game.color1.rgbColor,
                                rgbColor: game.color1
                            )
                            GradientSlidersView(customRGBColor: $game.color1)
                            .padding(.top)
                        
                        }
                            .padding()
                        VStack() {
                            ColorView(
                                color: game.color2.rgbColor,
                                rgbColor: game.color2
                            )
                            GradientSlidersView(customRGBColor: $game.color2)
                                .animation(.easeIn(duration: 1), value: isGameCompleted)
                                .padding(.top)
                        }
                            .padding()
                    }
                }
                if (evalueateGame) {
                    VStack {
                        CircleProgressBarView(
                            evaluationAccuracyPercentage: totalAccuracyPercentage
                        )
                            .frame(maxWidth: UIScreen.main.bounds.height / 5)
                    }
                }
            }
                .frame(maxHeight: isGameCompleted ? 0 : UIScreen.main.bounds.height / 4)
            if (!isGameCompleted && !evalueateGame) {
                Button {
                    playCorrectMusic()
                    evalueateGame = true
                } label: {
                    Spacer()
                    Text("Evaluate")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .padding()
            }
            else if (evalueateGame) {
                Button {
                    playRestartMusic()
                   restartGame()
               } label: {
                   Spacer()
                   Text("Generate new gradient")
                       .font(.title2)
                       .foregroundColor(.white)
                       .fontWeight(.semibold)
                       .opacity(evalueateGame ? 1 : 0)
                       .padding()
                   Spacer()
               }
                   .background(Color.indigo)
                   .cornerRadius(10)
                   .padding()
            }
            else if (isGameCompleted) {
                Button {
                    playRestartMusic()
                    restartGame()
                } label: {
                    Spacer()
                    Text("Generate new gradient")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .opacity(isGameCompleted ? 1 : 0)
                        .padding()
                    Spacer()
                }
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .padding()
            }
        }
            .background(.black)
    }
    
    func playCorrectMusic() {
        do {
            player = try AVAudioPlayer(contentsOf: arrayOfSounds[1].getURL(type: "wav")!)
            player?.prepareToPlay()
            player?.play()
            
        } catch {
            print("Error")
        }
       
    }
    
    func playRestartMusic() {
        do {
            player = try AVAudioPlayer(contentsOf: arrayOfSounds[3].getURL(type: "wav")!)
            player?.prepareToPlay()
            player?.play()
            
        } catch {
            print("Error")
        }
    }
    
}
