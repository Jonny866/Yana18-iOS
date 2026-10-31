import SwiftUI

struct HeroView: View {
    let onNext: () -> Void
    
    @State private var drawProgress: CGFloat = 0.0
    @State private var textAlpha: Double = 0.0
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Top label
                Text("ГЛАВА I · ДЛЯ ТЕБЯ")
                    .font(.manrope(size: 11))
                    .tracking(2.4)
                    .foregroundColor(Theme.champagneGold.opacity(0.85))
                    .padding(.top, 40)
                    .opacity(textAlpha)
                
                Spacer()
                
                // Big 18 Monogram
                VStack(spacing: 16) {
                    Text("18")
                        .font(.cormorant(size: 110))
                        .foregroundColor(Theme.champagneGold)
                        .scaleEffect(0.9 + 0.1 * drawProgress)
                        .opacity(Double(drawProgress))
                    
                    Text("18 лет чистой магии")
                        .font(.cormorant(size: 34))
                        .foregroundColor(Theme.textCream)
                        .multilineTextAlignment(.center)
                        .opacity(textAlpha)
                    
                    Text("Восемнадцать лет назад этот мир стал светлее, добрее и\u{00A0}наполнился смыслом. Сегодня твой день.")
                        .font(.manrope(size: 15))
                        .foregroundColor(Theme.textMuted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .opacity(textAlpha)
                }
                
                Spacer()
                
                LuxuryButtonView(title: "ПРОДОЛЖИТЬ", action: onNext)
                    .opacity(textAlpha)
                    .padding(.bottom, 48)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                drawProgress = 1.0
            }
            withAnimation(.easeOut(duration: 0.8).delay(0.5)) {
                textAlpha = 1.0
            }
        }
    }
}
