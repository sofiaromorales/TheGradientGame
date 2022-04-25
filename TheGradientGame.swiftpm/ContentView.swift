import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var showIntro = true
    @State var player: AVAudioPlayer?
    
    func playBackgroundMusic() {
        do {
            player = try AVAudioPlayer(contentsOf: arrayOfSounds[0].getURL(type: "mp3")!)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            player?.play()
            
        } catch {
            print("Error")
        }
       
    }
    
    var body: some View {
        
        VStack {
            if (showIntro) {
                IntroView(show: $showIntro)
            } else {
                GameView()
            }
        }
        .onAppear() {
            playBackgroundMusic()
        }
        
    }
}
