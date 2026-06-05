import Foundation

public struct DiningContext: Equatable, Sendable {
    public var park: Park
    public var currentLand: Land?
    public var minutesSinceMidnight: Int
    public var wantsReservation: Bool

    public init(park: Park, currentLand: Land?, minutesSinceMidnight: Int, wantsReservation: Bool) {
        self.park = park
        self.currentLand = currentLand
        self.minutesSinceMidnight = minutesSinceMidnight
        self.wantsReservation = wantsReservation
    }
}

public struct DiningRecommendation: Equatable, Sendable {
    public var location: DiningLocation
    public var score: Int
    public var vegetarianItems: [MenuItem]
    public var unrestrictedHighlights: [MenuItem]
    public var reason: String

    public init(location: DiningLocation, score: Int, vegetarianItems: [MenuItem], unrestrictedHighlights: [MenuItem], reason: String) {
        self.location = location
        self.score = score
        self.vegetarianItems = vegetarianItems
        self.unrestrictedHighlights = unrestrictedHighlights
        self.reason = reason
    }
}

public struct DiningEngine: Sendable {
    public init() {}

    public func recommendations(locations: [DiningLocation], context: DiningContext) -> [DiningRecommendation] {
        locations
            .filter { $0.park == context.park }
            .compactMap { location in
                let vegetarianItems = location.menuItems.filter(\.isVegetarian)
                guard !vegetarianItems.isEmpty else { return nil }

                var score = location.vegetarianRating + location.iconicValue / 2
                if context.currentLand == location.land {
                    score += 35
                }
                if context.wantsReservation {
                    score += location.supportsReservations ? 45 : -30
                } else {
                    score += location.supportsMobileOrder ? 20 : 0
                    score += location.serviceType == .snack ? 10 : 0
                }
                if isMealWindow(context.minutesSinceMidnight) {
                    score += location.serviceType == .tableService ? 12 : 8
                }

                let unrestricted = location.menuItems.filter { !$0.isVegetarian }
                let vegetarianNames = vegetarianItems.map(\.name).joined(separator: ", ")
                let reason = "\(location.name) has vegetarian picks: \(vegetarianNames). It fits the current food window."
                return DiningRecommendation(
                    location: location,
                    score: score,
                    vegetarianItems: vegetarianItems,
                    unrestrictedHighlights: unrestricted,
                    reason: reason
                )
            }
            .sorted { lhs, rhs in
                if lhs.score == rhs.score {
                    return lhs.location.iconicValue > rhs.location.iconicValue
                }
                return lhs.score > rhs.score
            }
    }

    private func isMealWindow(_ minutes: Int) -> Bool {
        (11 * 60...13 * 60 + 30).contains(minutes) || (17 * 60...20 * 60).contains(minutes)
    }
}
