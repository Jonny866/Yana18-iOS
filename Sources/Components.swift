import SwiftUI

struct StarParticle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var opacity: Double
}

struct StarfieldView: View {
    @State private var stars: [StarParticle] = (0..<35).map { _ in
        StarParticle(
            x: CGFloat.random(in: 0...1),
            y: CGFloat.random(in: 0...1),
            size: CGFloat.random(in: 1.5...3.5),
            opacity: Double.random(in: 0.2...0.8)
        )
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Theme.inkBackground.ignoresSafeArea()
                
                ForEach(stars) { star in
                    Circle()
                        .fill(Theme.peachGlow.opacity(star.opacity))
                        .frame(width: star.size, height: star.size)
                        .position(x: star.x * geo.size.width, y: star.y * geo.size.height)
                }
            }
        }
    }
}

struct LuxuryButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.manrope(size: 13, weight: .bold))
                .tracking(2.0)
                .foregroundColor(Theme.inkBackground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [Theme.champagneGold, Theme.roseQuartz],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: Theme.champagneGold.opacity(0.35), radius: 10, y: 4)
        }
        .padding(.horizontal, 24)
    }
}

struct LocalImageView: View {
    let name: String
    let folder: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        if let image = loadImage() {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else {
            Rectangle()
                .fill(Theme.inkSurface)
                .overlay(
                    Text("ПАМЯТНЫЙ КАДР")
                        .font(.manrope(size: 11))
                        .foregroundColor(Theme.champagneGold)
                )
        }
    }
    
    private func loadImage() -> UIImage? {
        if let direct = UIImage(named: name) { return direct }
        let exts = ["jpg", "png", "jpeg"]
        for ext in exts {
            if let path = Bundle.main.path(forResource: name, ofType: ext, inDirectory: folder) {
                if let img = UIImage(contentsOfFile: path) { return img }
            }
            if let path = Bundle.main.path(forResource: name, ofType: ext) {
                if let img = UIImage(contentsOfFile: path) { return img }
            }
        }
        return nil
    }
}
