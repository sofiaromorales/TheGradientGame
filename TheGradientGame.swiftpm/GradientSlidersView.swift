//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import SwiftUI

let SLIDER_STEP = 0.02

struct GradientSlidersView: View {

    @State private var orientation = UIDeviceOrientation.unknown
    @Binding var customRGBColor: RGBColor
    
    var body: some View {
        Group {
            if orientation.isLandscape {
                HStack {
                    Slider(value: $customRGBColor.red, in: 0...1, step: SLIDER_STEP)
                        .accentColor(Color.red)
                    Slider(value: $customRGBColor.green, in: 0...1, step: SLIDER_STEP)
                        .accentColor(Color.green)
                    Slider(value: $customRGBColor.blue, in: 0...1, step: SLIDER_STEP)
                        .accentColor(Color.blue)
                }
               
            } else {
                VStack {
                    Slider(value: $customRGBColor.red, in: 0...1, step: SLIDER_STEP)
                        .accentColor(Color.red)
                    Slider(value: $customRGBColor.green, in: 0...1, step: SLIDER_STEP)
                        .accentColor(Color.green)
                    Slider(value: $customRGBColor.blue, in: 0...1, step: SLIDER_STEP)
                        .accentColor(Color.blue)
                }
                
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        } 
        
    }
    
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
