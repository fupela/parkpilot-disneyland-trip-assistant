import Foundation

public enum SimulatedActionKind: String, Codable, Equatable, Sendable {
    case scanIn
    case bookLightningLane
    case standby
    case food
    case rest
    case entertainment
}

public struct SimulatedAction: Equatable, Sendable {
    public var kind: SimulatedActionKind
    public var title: String
    public var reason: String

    public init(kind: SimulatedActionKind, title: String, reason: String) {
        self.kind = kind
        self.title = title
        self.reason = reason
    }
}

public struct TripSimulator: Sendable {
    public init() {}

    public func simulateDay(park: Park, startingLand: Land) -> [SimulatedAction] {
        let now = Date(timeIntervalSince1970: 1_788_580_800)
        let attractions = TripSeed.attractions()
        let signals = simulatedSignals(for: park, updatedAt: now)
        let context = RecommendationContext(
            park: park,
            currentMinutes: 8 * 60 + 45,
            currentLand: startingLand,
            rideState: RideState(),
            signals: signals
        )
        let lightningLane = RecommendationEngine().nextLightningLane(attractions: attractions, context: context)
        let dining = DiningEngine().recommendations(
            locations: TripSeed.diningLocations(),
            context: DiningContext(
                park: park,
                currentLand: startingLand,
                minutesSinceMidnight: 12 * 60,
                wantsReservation: false
            )
        ).first

        var actions = [
            SimulatedAction(
                kind: .scanIn,
                title: "Confirm both tickets scanned in",
                reason: "Start active Lightning Lane recommendations."
            ),
            SimulatedAction(
                kind: .bookLightningLane,
                title: lightningLane.map { "Book \($0.attraction.name)" } ?? "Check Lightning Lane options",
                reason: lightningLane?.reason ?? "Use first-timer priority fallback."
            )
        ]

        if park == .disneyland {
            actions.append(
                SimulatedAction(
                    kind: .standby,
                    title: "Ride Pirates of the Caribbean standby",
                    reason: "Iconic first-timer ride that is not in Multi Pass."
                )
            )
        } else {
            actions.append(
                SimulatedAction(
                    kind: .standby,
                    title: "Prioritize Radiator Springs Racers in Cars Land",
                    reason: "Radiator Springs is a first-timer Cars Land priority, but it is not Multi Pass; use standby or manual Single Pass planning."
                )
            )
        }

        if let dining {
            actions.append(
                SimulatedAction(
                    kind: .food,
                    title: "Eat at \(dining.location.name)",
                    reason: dining.reason
                )
            )
        }

        actions.append(
            SimulatedAction(
                kind: .rest,
                title: "Build in a reset window",
                reason: "Protect energy for evening entertainment and late rides."
            )
        )
        actions.append(
            SimulatedAction(
                kind: .entertainment,
                title: "Protect the nighttime show window",
                reason: "First-time trips should not optimize rides at the expense of the finale."
            )
        )
        return actions
    }

    private func simulatedSignals(for park: Park, updatedAt: Date) -> [AttractionSignal] {
        TripSeed.attractions()
            .filter { $0.park == park && $0.supportsMultiPass }
            .map { attraction in
                let wait = attraction.firstTimerPriority >= 95 ? 85 : max(25, attraction.firstTimerPriority / 2)
                return AttractionSignal(
                    attractionID: attraction.id,
                    standbyMinutes: wait,
                    returnStartMinutes: 10 * 60 + (100 - attraction.firstTimerPriority),
                    returnEndMinutes: 11 * 60 + (100 - attraction.firstTimerPriority),
                    isTemporarilyClosed: false,
                    sourceUpdatedAt: updatedAt
                )
            }
    }
}
