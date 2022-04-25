//
//  File.swift
//  TheGradientGame
//
//  Created by Sofia Rodriguez Morales on 21/4/22.
//

import Foundation

struct SoundModel: Hashable {
    
    let name: String
    
    func getURL(type: String) -> URL? {
        return URL(string: Bundle.main.path(forResource: name, ofType: type)!)
    }
    
}

let arrayOfSounds: [SoundModel] = [
    .init(name: "purrple-cat-wild-strawberry"),
    .init(name: "neutral-beep"),
    .init(name: "Correct-answer"),
    .init(name: "game-beep"),
    .init(name: "unlock-beep")
]
