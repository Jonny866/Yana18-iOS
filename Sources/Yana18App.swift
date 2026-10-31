import SwiftUI

enum AppPhase: Int, CaseIterable {
    case gate = 0
    case hero = 1
    case time = 2
    case moments = 3
    case gallery = 4
    case wish = 5
    case final = 6
}

@main
struct Yana18App: App {
    @StateObject private var audio = BackgroundAudioPlayer.shared
    
    var body: some Scene {
        WindowGroup {
            MainContainerView()
                .environmentObject(audio)
                .preferredColorScheme(.dark)
        }
    }
}

struct MainContainerView: View {
    @EnvironmentObject var audio: BackgroundAudioPlayer
    @State private var phase: AppPhase = .gate
    
    var body: some View {
        ZStack {
            Theme.inkBackground.ignoresSafeArea()
            
            // Screen content
            Group {
                switch phase {
                case .gate:
                    GateView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            phase = .hero
                        }
                    }
                case .hero:
                    HeroView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            phase = .time
                        }
                    }
                case .time:
                    TimeView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            phase = .moments
                        }
                    }
                case .moments:
                    MomentsView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            phase = .gallery
                        }
                    }
                case .gallery:
                    GalleryView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            phase = .wish
                        }
                    }
                case .wish:
                    WishView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            phase = .final
                        }
                    }
                case .final:
                    FinalView()
                }
            }
            .transition(.opacity)
            
            // Navigation Bar (when past the gate)
            if phase != .gate {
                VStack {
                    HStack {
                        // Back Button
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                if let prev = AppPhase(rawValue: phase.rawValue - 1) {
                                    phase = prev
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Theme.champagneGold)
                                .frame(width: 36, height: 36)
                                .background(Theme.inkSurface.opacity(0.85))
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Theme.champagneBorder.opacity(0.4), lineWidth: 1)
                                )
                        }
                        
                        Spacer()
                        
                        // Progress Dots
                        HStack(spacing: 6) {
                            ForEach(1...6, id: \.self) { step in
                                Circle()
                                    .fill(step <= phase.rawValue ? Theme.champagneGold : Theme.champagneBorder.opacity(0.4))
                                    .frame(width: step == phase.rawValue ? 6 : 4, height: step == phase.rawValue ? 6 : 4)
                            }
                        }
                        
                        Spacer()
                        
                        // Audio Player Toggle
                        Button {
                            audio.toggle()
                        } label: {
                            Image(systemName: audio.isPlaying ? "speaker.wave.2.fill" : "speaker.slash.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Theme.champagneGold)
                                .frame(width: 36, height: 36)
                                .background(Theme.inkSurface.opacity(0.85))
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Theme.champagneBorder.opacity(0.4), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    Spacer()
                }
            }
        }
    }
}
