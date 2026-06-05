import Observation
import SwiftUI
import TripCore

public struct MapView: View {
    @Bindable var model: AppModel

    public init(model: AppModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(Park.allCases, id: \.self) { park in
                    Section(park.displayName) {
                        ForEach(attractions(for: park)) { attraction in
                            attractionRow(attraction)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Map")
            .background(ParkStyle.surface)
        }
    }

    private func attractions(for park: Park) -> [Attraction] {
        TripSeed.attractions()
            .filter { $0.park == park }
            .sorted { lhs, rhs in
                if lhs.land.rawValue == rhs.land.rawValue {
                    return lhs.firstTimerPriority > rhs.firstTimerPriority
                }
                return lhs.land.rawValue < rhs.land.rawValue
            }
    }

    private func attractionRow(_ attraction: Attraction) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(attraction.name)
                    .font(.headline)
                    .foregroundStyle(ParkStyle.ink)
                Spacer(minLength: 12)
                Text(attraction.supportsMultiPass ? "Multi Pass" : "No Multi Pass")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(attraction.supportsMultiPass ? ParkStyle.blue : ParkStyle.muted)
            }
            Text("\(landName(attraction.land)) · first-timer priority \(attraction.firstTimerPriority)")
                .font(.caption)
                .foregroundStyle(ParkStyle.muted)
        }
        .padding(.vertical, 4)
    }

    private func landName(_ land: Land) -> String {
        switch land {
        case .adventureland: "Adventureland"
        case .frontierland: "Frontierland"
        case .newOrleansSquare: "New Orleans Square"
        case .fantasyland: "Fantasyland"
        case .tomorrowland: "Tomorrowland"
        case .galaxysEdge: "Galaxy's Edge"
        case .toontown: "Toontown"
        case .mainStreet: "Main Street"
        case .carsLand: "Cars Land"
        case .pixarPier: "Pixar Pier"
        case .avengersCampus: "Avengers Campus"
        case .buenaVistaStreet: "Buena Vista Street"
        case .hollywoodLand: "Hollywood Land"
        case .grizzlyPeak: "Grizzly Peak"
        case .sanFransokyoSquare: "San Fransokyo Square"
        case .paradiseGardens: "Paradise Gardens"
        }
    }
}
