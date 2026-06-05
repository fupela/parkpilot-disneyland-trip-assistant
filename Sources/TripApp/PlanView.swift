import Observation
import SwiftUI

public struct PlanView: View {
    @Bindable var model: AppModel

    public init(model: AppModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            List {
                Section("July 10 · Disneyland Park") {
                    planBlock(
                        title: "Morning",
                        detail: "Scan in together, open the best Multi Pass handoff, then work Adventureland and New Orleans Square while waits are manageable."
                    )
                    planBlock(
                        title: "Midday",
                        detail: "Mix standby classics with the next eligibility window. Keep Pirates and Haunted Mansion as nearby flexible anchors."
                    )
                    planBlock(
                        title: "Evening",
                        detail: "Protect show time, use the final high-value return window, and revisit the first-timer favorites that landed best."
                    )
                }

                Section("July 11 · Disney California Adventure") {
                    planBlock(
                        title: "Morning",
                        detail: "Prioritize Cars Land and Avengers Campus. Treat Radiator Springs Racers as a first-timer priority, not a Multi Pass booking."
                    )
                    planBlock(
                        title: "Midday",
                        detail: "Use food and shade as part of the plan, then loop Pixar Pier once return windows and standby waits settle."
                    )
                    planBlock(
                        title: "Evening",
                        detail: "Return to Cars Land atmosphere, keep table-service timing flexible, and save energy for the late-day ride push."
                    )
                }
            }
            .listStyle(.plain)
            .navigationTitle("Plan")
            .background(ParkStyle.surface)
        }
    }

    private func planBlock(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundStyle(ParkStyle.ink)
            Text(detail)
                .font(.subheadline)
                .foregroundStyle(ParkStyle.muted)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 4)
    }
}
