//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI

struct ColorView: View {
    
    let color: Color
    let rgbColor: RGBColor
    var redRGB: String {
        String(format: "%.0f", (rgbColor.red * 255))
    }
    var greenRGB: String {
        String(format: "%.0f", (rgbColor.green * 255))
    }
    var blueRGB: String {
       String(format: "%.0f", (rgbColor.blue * 255))
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            VStack {
                Text("R: \(redRGB)")
                Text("G: \(greenRGB)")
                Text("B: \(blueRGB)")
            }
            .padding(5)
            .background(.ultraThinMaterial, in:RoundedRectangle(cornerRadius: 10))
            .padding(5)
        }
    }
    
}
