import Foundation
import AVFoundation

final class BackgroundAudioPlayer: ObservableObject {
    static let shared = BackgroundAudioPlayer()
    private var player: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    
    private init() {
        setupAudio()
    }
    
    func setupAudio() {
        guard let url = Bundle.main.url(forResource: "barbariki_birthday", withExtension: "mp4", subdirectory: "music")
                ?? Bundle.main.url(forResource: "barbariki_birthday", withExtension: "mp4") else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Infinite loop
            player?.prepareToPlay()
            player?.volume = 0.8
        } catch {
            print("Audio error: \(error)")
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
}
