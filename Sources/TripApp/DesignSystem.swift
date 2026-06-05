import SwiftUI

enum ParkStyle {
    static let ink = Color(red: 0.06, green: 0.09, blue: 0.14)
    static let navy = Color(red: 0.08, green: 0.16, blue: 0.26)
    static let blue = Color(red: 0.10, green: 0.35, blue: 0.65)
    static let gold = Color(red: 0.80, green: 0.50, blue: 0.16)
    static let green = Color(red: 0.08, green: 0.39, blue: 0.26)
    static let red = Color(red: 0.68, green: 0.16, blue: 0.16)
    static let orange = Color(red: 0.78, green: 0.39, blue: 0.10)
    static let surface = Color(red: 0.94, green: 0.96, blue: 0.97)
    static let card = Color.white
    static let line = Color(red: 0.81, green: 0.85, blue: 0.89)
    static let muted = Color(red: 0.36, green: 0.42, blue: 0.50)
}

extension View {
    func premiumCard() -> some View {
        padding(16)
            .background(ParkStyle.card)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(ParkStyle.line.opacity(0.75), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}
