//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI

class RGBColor: ObservableObject, Equatable, Hashable {
    
    static func == (lhs: RGBColor, rhs: RGBColor) -> Bool {
        lhs.rgbColor == rhs.rgbColor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rgbColor)
    }
    
    @Published var red: Double
    @Published var green: Double
    @Published var blue: Double
    
    var rgbColor: Color {
        Color(red: red, green: green, blue: blue, opacity: 1)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
