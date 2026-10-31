import SwiftUI

enum Theme {
    static let inkBackground = Color(red: 0.043, green: 0.039, blue: 0.063) // #0B0A10
    static let inkSurface = Color(red: 0.075, green: 0.071, blue: 0.106)    // #13121B
    static let inkElevated = Color(red: 0.110, green: 0.102, blue: 0.153)   // #1C1A27
    static let champagneGold = Color(red: 0.898, green: 0.776, blue: 0.592) // #E5C697
    static let champagneBorder = Color(red: 0.290, green: 0.243, blue: 0.192)
    static let roseQuartz = Color(red: 0.910, green: 0.647, blue: 0.596)
    static let peachGlow = Color(red: 0.953, green: 0.773, blue: 0.659)
    static let textCream = Color(red: 0.980, green: 0.961, blue: 0.933)
    static let textMuted = Color(red: 0.651, green: 0.624, blue: 0.580)
}

extension Font {
    static func cormorant(size: CGFloat) -> Font {
        .custom("CormorantGaramond-Regular", size: size)
    }
    
    static func cormorantItalic(size: CGFloat) -> Font {
        .custom("CormorantGaramond-Italic", size: size)
    }
    
    static func manrope(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("Manrope-Regular", size: size)
    }
    
    static func caveat(size: CGFloat) -> Font {
        .custom("Caveat-Regular", size: size)
    }
}

struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Theme.inkSurface.opacity(0.85))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Theme.champagneBorder.opacity(0.45), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius))
    }
}
