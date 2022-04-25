//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI

class Game: ObservableObject {
    
    @Published var bColor1: RGBColor
    @Published var bColor2: RGBColor
    @Published var color1: RGBColor
    @Published var color2: RGBColor
    
    func regenerate() {
        func generateRandomRGBColor() -> RGBColor {
            RGBColor(
                red: Double(Float.random(in: 0...1)),
                green: Double(Float.random(in: 0...1)),
                blue: Double(Float.random(in: 0...1))
            )
        }
        bColor1 = generateRandomRGBColor()
        bColor2 = generateRandomRGBColor()
        color1 = generateRandomRGBColor()
        color2 = generateRandomRGBColor()
    }
    
    init() {
        func generateRandomRGBColor() -> RGBColor {
            RGBColor(
                red: Double(Float.random(in: 0...1)),
                green: Double(Float.random(in: 0...1)),
                blue: Double(Float.random(in: 0...1))
            )
        }
        bColor1 = generateRandomRGBColor()
        bColor2 = generateRandomRGBColor()
        color1 = generateRandomRGBColor()
        color2 = generateRandomRGBColor()
    }
    
}
