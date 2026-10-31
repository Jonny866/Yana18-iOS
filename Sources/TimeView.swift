import SwiftUI

struct TimeView: View {
    let onNext: () -> Void
    
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timeComponents: (years: Int, days: Int, hours: Int, minutes: Int, seconds: Int) {
        let diff = Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: ContentData.birthDate, to: now)
        let totalDays = Calendar.current.dateComponents([.day], from: ContentData.birthDate, to: now).day ?? 6574
        return (
            years: diff.year ?? 18,
            days: totalDays,
            hours: diff.hour ?? 0,
            minutes: diff.minute ?? 0,
            seconds: diff.second ?? 0
        )
    }
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Top Header
                VStack(spacing: 8) {
                    Text("ГЛАВА II · ЛИЧНОЕ ВРЕМЯ")
                        .font(.manrope(size: 11))
                        .tracking(2.4)
                        .foregroundColor(Theme.champagneGold.opacity(0.85))
                        .padding(.top, 40)
                    
                    Text("18 лет сияния")
                        .font(.cormorant(size: 34))
                        .foregroundColor(Theme.textCream)
                    
                    Text("Точный хронометраж твоего пути с\u{00A0}первого вдоха")
                        .font(.manrope(size: 14))
                        .foregroundColor(Theme.textMuted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                Spacer()
                
                // Chronometer Grid
                VStack(spacing: 16) {
                    let comps = timeComponents
                    
                    HStack(spacing: 16) {
                        MetricCard(value: "\(comps.years)", label: "ЛЕТ")
                        MetricCard(value: "\(comps.days)", label: "ДНЕЙ")
                    }
                    
                    HStack(spacing: 12) {
                        MetricCard(value: String(format: "%02d", comps.hours), label: "ЧАСОВ")
                        MetricCard(value: String(format: "%02d", comps.minutes), label: "МИНУТ")
                        MetricCard(value: String(format: "%02d", comps.seconds), label: "СЕКУНД")
                    }
                    
                    // Footnote card
                    Text("Более 157\u{00A0}000 часов, наполненных твоими мыслями, победами, смехом и\u{00A0}мечтами. Каждое мгновение имеет значение.")
                        .font(.manrope(size: 13))
                        .foregroundColor(Theme.textMuted)
                        .multilineTextAlignment(.center)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .glassCard(cornerRadius: 16)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                LuxuryButtonView(title: "ВПЕРЕД В ГАЛЕРЕЮ", action: onNext)
                    .padding(.bottom, 48)
            }
        }
        .onReceive(timer) { input in
            now = input
        }
    }
}

struct MetricCard: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.cormorant(size: 32))
                .foregroundColor(Theme.champagneGold)
            
            Text(label)
                .font(.manrope(size: 10, weight: .bold))
                .tracking(1.8)
                .foregroundColor(Theme.roseQuartz.opacity(0.85))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .glassCard(cornerRadius: 16)
    }
}
