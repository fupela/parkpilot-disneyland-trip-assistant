import Observation
import SwiftUI
import TripCore

public struct TodayView: View {
    @Environment(\.openURL) private var openURL
    @Bindable var model: AppModel

    public init(model: AppModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header
                    FreshnessBanner(freshness: model.freshness)
                    recommendationCard
                    metricGrid
                    foodCard
                }
                .padding(18)
            }
            .background(ParkStyle.surface)
            .navigationTitle("Today")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Disneyland Park, Jul 10, 8:45 AM")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(ParkStyle.muted)
            Text("Your next best move")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(ParkStyle.ink)
                .lineLimit(2)
        }
    }

    @ViewBuilder
    private var recommendationCard: some View {
        if let recommendation = model.recommendation {
            let handoff = DisneyHandoff.lightningLane(attractionName: recommendation.attraction.name)

            VStack(alignment: .leading, spacing: 14) {
                Text("Recommended handoff")
                    .font(.caption.weight(.black))
                    .foregroundStyle(ParkStyle.blue)
                    .textCase(.uppercase)
                Text(recommendation.attraction.name)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(ParkStyle.ink)
                    .lineLimit(2)
                Text(recommendation.reason)
                    .font(.body)
                    .foregroundStyle(ParkStyle.muted)
                    .fixedSize(horizontal: false, vertical: true)
                FlowChips {
                    ScoreChip(label: "Save ~\(recommendation.estimatedMinutesSaved) min", color: ParkStyle.blue)
                    if recommendation.factors.contains(where: { $0.label == "High wait saved" }) {
                        ScoreChip(label: "High value", color: ParkStyle.gold)
                    }
                    if let start = recommendation.returnStartMinutes {
                        ScoreChip(label: "Return \(timeString(start))", color: ParkStyle.green)
                    }
                }
                Button {
                    if let targetURL = handoff.targetURL {
                        openURL(targetURL)
                    }
                    model.confirmBookedRecommendation()
                } label: {
                    Text(handoff.actionTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                }
                .buttonStyle(.borderedProminent)
                .tint(ParkStyle.blue)
                .accessibilityHint("Use the Disney app to confirm this manually. Demo state is updated locally.")
            }
            .premiumCard()
        } else {
            Text("No Multi Pass recommendation is available right now.")
                .font(.headline)
                .foregroundStyle(ParkStyle.muted)
                .premiumCard()
        }
    }

    private var metricGrid: some View {
        Grid(horizontalSpacing: 12, verticalSpacing: 12) {
            GridRow {
                metric(title: "Next eligible", value: "10:45 AM")
                metric(title: "Nearby standby", value: "Pirates · 15 min")
            }
        }
    }

    private func metric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(ParkStyle.muted)
            Text(value)
                .font(.headline.weight(.bold))
                .foregroundStyle(ParkStyle.ink)
                .lineLimit(2)
                .minimumScaleFactor(0.86)
        }
        .frame(maxWidth: .infinity, minHeight: 70, alignment: .leading)
        .premiumCard()
    }

    @ViewBuilder
    private var foodCard: some View {
        if let dining = model.diningRecommendation {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Food nearby")
                            .font(.caption.weight(.black))
                            .foregroundStyle(ParkStyle.green)
                            .textCase(.uppercase)
                        Text(dining.location.name)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(ParkStyle.ink)
                    }
                    Spacer(minLength: 12)
                    ScoreChip(label: "Vegetarian", color: ParkStyle.green)
                }
                Text(dining.vegetarianItems.map(\.name).joined(separator: " · "))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(ParkStyle.muted)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .premiumCard()
        }
    }

    private func timeString(_ minutes: Int) -> String {
        let hour = minutes / 60
        let minute = minutes % 60
        let period = hour >= 12 ? "PM" : "AM"
        let displayHour = hour > 12 ? hour - 12 : max(hour, 1)
        return "\(displayHour):\(String(format: "%02d", minute)) \(period)"
    }
}

private struct FlowChips<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 112), spacing: 8, alignment: .leading)],
            alignment: .leading,
            spacing: 8
        ) {
            content
        }
    }
}
