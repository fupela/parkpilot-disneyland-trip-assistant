import Observation
import SwiftUI
import TripCore

public struct FoodView: View {
    @Bindable var model: AppModel

    public init(model: AppModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(TripSeed.diningLocations()) { location in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .firstTextBaseline) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(location.name)
                                    .font(.headline)
                                    .foregroundStyle(ParkStyle.ink)
                                Text("\(location.park.displayName) · \(serviceLabel(location.serviceType))")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(ParkStyle.muted)
                            }
                            Spacer(minLength: 12)
                            if location.supportsReservations {
                                ScoreChip(label: "Reserve", color: ParkStyle.blue)
                            } else if location.supportsMobileOrder {
                                ScoreChip(label: "Mobile", color: ParkStyle.green)
                            }
                        }

                        ForEach(location.menuItems.filter(\.isVegetarian)) { item in
                            VStack(alignment: .leading, spacing: 4) {
                                Label(item.name, systemImage: "leaf.fill")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(ParkStyle.green)
                                if !item.notes.isEmpty {
                                    Text(item.notes)
                                        .font(.caption)
                                        .foregroundStyle(ParkStyle.muted)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Food")
            .background(ParkStyle.surface)
        }
    }

    private func serviceLabel(_ serviceType: DiningLocation.ServiceType) -> String {
        switch serviceType {
        case .quickService: "Quick service"
        case .snack: "Snack"
        case .tableService: "Table service"
        }
    }
}
