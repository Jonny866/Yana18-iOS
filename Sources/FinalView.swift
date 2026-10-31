import SwiftUI

struct FinalView: View {
    @State private var showSecret = false
    @State private var starPulse = false
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Header with Secret Star
                HStack {
                    Text("ГЛАВА VI · ТОЛЬКО ДЛЯ ТВОИХ ГЛАЗ")
                        .font(.manrope(size: 11))
                        .tracking(2.0)
                        .foregroundColor(Theme.champagneGold.opacity(0.85))
                    
                    Spacer()
                    
                    // Secret Interactive Star
                    Button {
                        showSecret = true
                    } label: {
                        Image(systemName: "sparkle")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.champagneGold)
                            .scaleEffect(starPulse ? 1.25 : 0.95)
                            .shadow(color: Theme.peachGlow, radius: starPulse ? 8 : 2)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.top, 40)
                
                // Main Letter Card
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Моей любимой Яне")
                            .font(.cormorant(size: 32))
                            .foregroundColor(Theme.champagneGold)
                            .padding(.top, 8)
                        
                        Text(ContentData.letterText)
                            .font(.caveat(size: 21))
                            .foregroundColor(Theme.textCream.opacity(0.95))
                            .lineSpacing(8)
                        
                        Divider()
                            .background(Theme.champagneBorder.opacity(0.5))
                            .padding(.vertical, 8)
                        
                        HStack {
                            Spacer()
                            Text("Навеки твоя, \(ContentData.senderName)")
                                .font(.caveat(size: 24))
                                .foregroundColor(Theme.roseQuartz)
                        }
                    }
                    .padding(28)
                    .glassCard(cornerRadius: 24)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }
            }
            
            // Secret Popup Dialog
            if showSecret {
                ZStack {
                    Color.black.opacity(0.85).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("СОКРОВЕННОЕ ПОСЛАНИЕ")
                            .font(.manrope(size: 12, weight: .bold))
                            .tracking(2.4)
                            .foregroundColor(Theme.champagneGold)
                        
                        Text(ContentData.secretMessage)
                            .font(.caveat(size: 22))
                            .foregroundColor(Theme.textCream)
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                            .padding(.horizontal, 16)
                        
                        Button {
                            showSecret = false
                        } label: {
                            Text("ЗАКРЫТЬ")
                                .font(.manrope(size: 12, weight: .bold))
                                .tracking(1.8)
                                .foregroundColor(Theme.roseQuartz)
                                .padding(.top, 12)
                        }
                    }
                    .padding(32)
                    .glassCard(cornerRadius: 24)
                    .padding(.horizontal, 28)
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                starPulse = true
            }
        }
    }
}
