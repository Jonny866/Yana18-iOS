import SwiftUI

struct MomentsView: View {
    let onNext: () -> Void
    
    @State private var currentIndex: Int = 0
    private let moments = ContentData.moments
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Top Header
                VStack(spacing: 6) {
                    Text("ГЛАВА III · 18 ПРИЧИН ЛЮБВИ")
                        .font(.manrope(size: 11))
                        .tracking(2.4)
                        .foregroundColor(Theme.champagneGold.opacity(0.85))
                        .padding(.top, 40)
                    
                    Text("Почему мое сердце твое")
                        .font(.cormorant(size: 32))
                        .foregroundColor(Theme.textCream)
                    
                    Text("Листай вправо: 18 признаний для тебя")
                        .font(.manrope(size: 13))
                        .foregroundColor(Theme.textMuted)
                }
                
                // Paging Card Carousel
                TabView(selection: $currentIndex) {
                    ForEach(moments.indices, id: \.self) { idx in
                        let moment = moments[idx]
                        
                        VStack(spacing: 14) {
                            // Top metadata
                            HStack {
                                Text("ПРИЧИНА \(String(format: "%02d", moment.id))")
                                    .font(.manrope(size: 11, weight: .bold))
                                    .tracking(1.8)
                                    .foregroundColor(Theme.roseQuartz)
                                
                                Spacer()
                                
                                Text(moment.year)
                                    .font(.cormorant(size: 20))
                                    .foregroundColor(Theme.champagneGold)
                            }
                            
                            // Image
                            LocalImageView(name: moment.imageName, folder: "photos", contentMode: .fill)
                                .frame(height: 220)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Theme.champagneBorder.opacity(0.3), lineWidth: 1)
                                )
                            
                            // Title & Description
                            VStack(alignment: .leading, spacing: 6) {
                                Text(moment.title)
                                    .font(.cormorant(size: 22))
                                    .foregroundColor(Theme.textCream)
                                
                                Text(moment.subtitle)
                                    .font(.manrope(size: 12))
                                    .foregroundColor(Theme.champagneGold.opacity(0.85))
                                
                                Text(moment.story)
                                    .font(.manrope(size: 13))
                                    .foregroundColor(Theme.textMuted)
                                    .lineSpacing(4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer(minLength: 0)
                        }
                        .padding(20)
                        .glassCard(cornerRadius: 20)
                        .padding(.horizontal, 24)
                        .tag(idx)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .padding(.vertical, 16)
                
                // Bottom Page Indicator & Next Button
                VStack(spacing: 12) {
                    Text("\(currentIndex + 1) / \(moments.count)")
                        .font(.manrope(size: 12))
                        .tracking(1.8)
                        .foregroundColor(Theme.champagneGold)
                    
                    LuxuryButtonView(title: "ДАЛЕЕ К СОЗВЕЗДИЯМ", action: onNext)
                }
                .padding(.bottom, 40)
            }
        }
    }
}
