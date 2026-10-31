import SwiftUI

struct GateView: View {
    let onUnlocked: () -> Void
    
    @State private var progress: CGFloat = 0.0
    @State private var isHolding: Bool = false
    @State private var rotationAngle: Double = 0.0
    @State private var timer: Timer? = nil
    
    private let haptic = UIImpactFeedbackGenerator(style: .medium)
    private let heavyHaptic = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Top Header
                VStack(spacing: 12) {
                    Text("ПОДАРОЧНЫЙ ВЫПУСК · 18 ЛЕТ")
                        .font(.manrope(size: 11))
                        .tracking(2.5)
                        .foregroundColor(Theme.champagneGold.opacity(0.85))
                        .padding(.top, 40)
                    
                    Text("Для \(ContentData.celebrantGenitive)")
                        .font(.cormorant(size: 44))
                        .foregroundColor(Theme.textCream)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                    
                    Text("Личная карта времени и\u{00A0}созвездие твоих мгновений")
                        .font(.manrope(size: 15))
                        .foregroundColor(Theme.textMuted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                Spacer()
                
                // Interactive Center: Pure Rotating Iris with generous breathing margin
                VStack(spacing: 20) {
                    ZStack {
                        // Ambient outer glow
                        Circle()
                            .fill(Theme.peachGlow.opacity(0.12))
                            .frame(width: 206, height: 206)
                        
                        // Static track circle
                        Circle()
                            .stroke(Theme.champagneBorder.opacity(0.45), lineWidth: 2)
                            .frame(width: 190, height: 190)
                        
                        // Active sweep progress arc
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [Theme.champagneGold, Theme.roseQuartz, Theme.peachGlow, Theme.champagneGold]),
                                    center: .center,
                                    startAngle: .degrees(-90),
                                    endAngle: .degrees(270)
                                ),
                                style: StrokeStyle(lineWidth: 4, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 190, height: 190)
                        
                        // Pure Rotating Iris (completely unobstructed)
                        LocalImageView(name: "iris_eye", folder: "illustrations", contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .rotationEffect(.degrees(rotationAngle))
                    }
                    .frame(width: 210, height: 210)
                    
                    // Shifted below the Iris: Number "18" and Action prompt
                    VStack(spacing: 4) {
                        Text("18")
                            .font(.cormorant(size: 44))
                            .foregroundColor(Theme.champagneGold)
                        
                        Text("ОТКРЫТЬ ПОДАРОК")
                            .font(.manrope(size: 11, weight: .bold))
                            .tracking(2.0)
                            .foregroundColor(Theme.roseQuartz.opacity(0.95))
                    }
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isHolding {
                                startHolding()
                            }
                        }
                        .onEnded { _ in
                            stopHolding()
                        }
                )
                
                Spacer()
                
                // Bottom Subtitle
                Text("Удерживай кольцо,\nчтобы открыть подарок")
                    .font(.manrope(size: 13))
                    .foregroundColor(Theme.textMuted.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 48)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 36).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }
            haptic.prepare()
            heavyHaptic.prepare()
        }
    }
    
    private func startHolding() {
        isHolding = true
        haptic.impactOccurred()
        
        let interval: TimeInterval = 0.03
        let duration: TimeInterval = 1.5
        let step = interval / duration
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { t in
            if progress < 1.0 {
                progress = min(1.0, progress + CGFloat(step))
            } else {
                t.invalidate()
                heavyHaptic.impactOccurred()
                BackgroundAudioPlayer.shared.play()
                onUnlocked()
            }
        }
    }
    
    private func stopHolding() {
        isHolding = false
        timer?.invalidate()
        timer = nil
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            progress = 0.0
        }
    }
}
