import SwiftUI

struct GalleryView: View {
    let onNext: () -> Void
    
    @State private var selectedItem: GalleryItem? = nil
    private let items = ContentData.galleryItems
    
    var body: some View {
        ZStack {
            StarfieldView()
            
            VStack(spacing: 0) {
                // Top Header
                VStack(spacing: 6) {
                    Text("ГЛАВА IV · ОСОБЫЕ КАДРЫ")
                        .font(.manrope(size: 11))
                        .tracking(2.4)
                        .foregroundColor(Theme.champagneGold.opacity(0.85))
                        .padding(.top, 40)
                    
                    Text("Галерея созвездий")
                        .font(.cormorant(size: 32))
                        .foregroundColor(Theme.textCream)
                    
                    Text("То, как ты улыбаешься этому миру")
                        .font(.manrope(size: 13))
                        .foregroundColor(Theme.textMuted)
                }
                
                // Bento Scroll Grid
                ScrollView {
                    VStack(spacing: 12) {
                        // Item 1 (Wide span-two couple photo)
                        if items.count > 0 {
                            BentoCard(item: items[0], height: 180) {
                                selectedItem = items[0]
                            }
                        }
                        
                        // Items 2 & 3 (Side by side)
                        HStack(spacing: 12) {
                            if items.count > 1 {
                                BentoCard(item: items[1], height: 170) {
                                    selectedItem = items[1]
                                }
                            }
                            if items.count > 2 {
                                BentoCard(item: items[2], height: 170) {
                                    selectedItem = items[2]
                                }
                            }
                        }
                        
                        // Item 4 (Wide span-two greenhouse photo)
                        if items.count > 3 {
                            BentoCard(item: items[3], height: 180) {
                                selectedItem = items[3]
                            }
                        }
                        
                        // Items 5 & 6 (Side by side)
                        HStack(spacing: 12) {
                            if items.count > 4 {
                                BentoCard(item: items[4], height: 170) {
                                    selectedItem = items[4]
                                }
                            }
                            if items.count > 5 {
                                BentoCard(item: items[5], height: 170) {
                                    selectedItem = items[5]
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                
                LuxuryButtonView(title: "КНИГА ПОЖЕЛАНИЙ", action: onNext)
                    .padding(.bottom, 40)
            }
            
            // Fullscreen preview sheet
            if let selected = selectedItem {
                ZStack {
                    Color.black.opacity(0.92).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Button {
                                selectedItem = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(Theme.textCream.opacity(0.7))
                            }
                            .padding(.trailing, 24)
                            .padding(.top, 40)
                        }
                        
                        Spacer()
                        
                        LocalImageView(name: selected.imageName, folder: "gallery", contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 6) {
                            Text(selected.title)
                                .font(.cormorant(size: 24))
                                .foregroundColor(Theme.textCream)
                            
                            Text(selected.location)
                                .font(.manrope(size: 13))
                                .foregroundColor(Theme.champagneGold)
                        }
                        
                        Spacer()
                    }
                }
                .transition(.opacity)
            }
        }
    }
}

struct BentoCard: View {
    let item: GalleryItem
    let height: CGFloat
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                LocalImageView(name: item.imageName, folder: "gallery", contentMode: .fill)
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                // Gradient overlay
                LinearGradient(
                    colors: [Color.clear, Color.black.opacity(0.85)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.cormorant(size: 16))
                        .foregroundColor(Theme.textCream)
                    
                    Text(item.location)
                        .font(.manrope(size: 10))
                        .foregroundColor(Theme.champagneGold.opacity(0.9))
                }
                .padding(12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Theme.champagneBorder.opacity(0.35), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
