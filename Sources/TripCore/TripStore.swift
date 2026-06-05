import Foundation

public enum DataFreshness: Equatable, Sendable {
    case live
    case stale(minutesOld: Int)
    case unavailable
}

public struct SharedTripState: Equatable, Sendable {
    public var trip: Trip
    public var rideState: RideState
    public var alerts: [TripAlert]
    public var freshness: DataFreshness
    public var lastImportantChangeActorID: String?

    public init(
        trip: Trip,
        rideState: RideState = RideState(),
        alerts: [TripAlert] = [],
        freshness: DataFreshness = .unavailable,
        lastImportantChangeActorID: String? = nil
    ) {
        self.trip = trip
        self.rideState = rideState
        self.alerts = alerts
        self.freshness = freshness
        self.lastImportantChangeActorID = lastImportantChangeActorID
    }
}

public protocol TripStore: Sendable {
    func currentState() async -> SharedTripState
    func markCompleted(attractionID: String, actorID: String) async
    func setBookedLightningLane(_ booking: BookedLightningLane, actorID: String) async
    func setFreshness(_ freshness: DataFreshness) async
}

public actor InMemoryTripStore: TripStore {
    private var state: SharedTripState

    public init(initial: SharedTripState) {
        self.state = initial
    }

    public func currentState() async -> SharedTripState {
        state
    }

    public func markCompleted(attractionID: String, actorID: String) async {
        state.rideState.completedAttractionIDs.insert(attractionID)
    }

    public func setBookedLightningLane(_ booking: BookedLightningLane, actorID: String) async {
        state.rideState.bookedLightningLane = booking
        state.lastImportantChangeActorID = actorID
    }

    public func setFreshness(_ freshness: DataFreshness) async {
        state.freshness = freshness
    }
}
