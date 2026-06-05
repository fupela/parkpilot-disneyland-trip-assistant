import SwiftUI
import TripCore

struct ScoreChip: View {
    var label: String
    var color: Color

    var body: some View {
        Text(label)
            .font(.caption.weight(.bold))
            .foregroundStyle(color)
            .lineLimit(1)
            .minimumScaleFactor(0.86)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(color.opacity(0.12))
            .clipShape(Capsule())
    }
}

struct FreshnessBanner: View {
    var freshness: DataFreshness

    var body: some View {
        switch freshness {
        case .live:
            EmptyView()
        case .stale(let minutes):
            Text("Data is \(minutes) minutes old. Recommendations are using fallback confidence.")
                .freshnessStyle(foreground: ParkStyle.orange)
        case .unavailable:
            Text("Live data unavailable. Using first-timer fallback plan.")
                .freshnessStyle(foreground: ParkStyle.red)
        }
    }
}

private extension View {
    func freshnessStyle(foreground: Color) -> some View {
        font(.caption.weight(.semibold))
            .foregroundStyle(foreground)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(foreground.opacity(0.11))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
