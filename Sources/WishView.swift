import SwiftUI

struct WishView: View {
    let onNext: () -> Void
    
    @State private var currentIndex: Int = 0
    private let wishes = ContentData.wishCards
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Top Header
                VStack(spacing: 6) {
                    Text("ГЛАВА V · КНИГА ПОЖЕЛАНИЙ")
                        .font(.manrope(size: 11))
                        .tracking(2.4)
                        .foregroundColor(Theme.champagneGold.opacity(0.85))
                        .padding(.top, 40)
                    
                    Text("Для твоего нового года")
                        .font(.cormorant(size: 32))
                        .foregroundColor(Theme.textCream)
                    
                    Text("Коснись карточки, чтобы открыть следующее пожелание")
                        .font(.manrope(size: 13))
                        .foregroundColor(Theme.textMuted)
                }
                
                Spacer()
                
                // Active Wish Card
                if currentIndex < wishes.count {
                    let wish = wishes[currentIndex]
                    
                    Button {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                            currentIndex = (currentIndex + 1) % wishes.count
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Text("ПОЖЕЛАНИЕ \(currentIndex + 1) ИЗ \(wishes.count)")
                                .font(.manrope(size: 11, weight: .bold))
                                .tracking(2.0)
                                .foregroundColor(Theme.roseQuartz)
                            
                            Text(wish.headline)
                                .font(.cormorant(size: 30))
                                .foregroundColor(Theme.textCream)
                                .multilineTextAlignment(.center)
                            
                            Divider()
                                .background(Theme.champagneBorder.opacity(0.5))
                            
                            Text(wish.note)
                                .font(.manrope(size: 15))
                                .foregroundColor(Theme.textMuted)
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                                .padding(.horizontal, 8)
                        }
                        .padding(32)
                        .frame(maxWidth: .infinity)
                        .glassCard(cornerRadius: 24)
                        .padding(.horizontal, 28)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                LuxuryButtonView(title: "СОКРОВЕННОЕ ПОСЛАНИЕ", action: onNext)
                    .padding(.bottom, 48)
            }
        }
    }
}
