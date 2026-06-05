import Foundation
import Observation
import TripCore

@MainActor
@Observable
public final class AppModel {
    public var trip: Trip
    public var rideState: RideState
    public var freshness: DataFreshness
    public var recommendation: LightningLaneRecommendation?
    public var diningRecommendation: DiningRecommendation?
    public var alerts: [TripAlert]

    private let recommendationEngine = RecommendationEngine()
    private let diningEngine = DiningEngine()

    public init() {
        trip = TripSeed.defaultTrip()
        rideState = RideState()
        freshness = .live
        alerts = [
            TripAlert(
                id: "scan-in",
                kind: .scanInPrompt,
                title: "Did both of you scan in?",
                body: "Confirm to start active Lightning Lane recommendations.",
                priority: 100
            )
        ]
        refreshForDemo()
    }

    public func refreshForDemo() {
        let now = Date(timeIntervalSince1970: 1_788_580_800)
        let context = RecommendationContext(
            park: .disneyland,
            currentMinutes: 8 * 60 + 45,
            currentLand: .adventureland,
            rideState: rideState,
            signals: [
                AttractionSignal(attractionID: "indiana-jones", standbyMinutes: 75, returnStartMinutes: 10 * 60 + 15, returnEndMinutes: 11 * 60 + 15, isTemporarilyClosed: false, sourceUpdatedAt: now),
                AttractionSignal(attractionID: "space-mountain", standbyMinutes: 65, returnStartMinutes: 10 * 60 + 45, returnEndMinutes: 11 * 60 + 45, isTemporarilyClosed: false, sourceUpdatedAt: now),
                AttractionSignal(attractionID: "matterhorn", standbyMinutes: 35, returnStartMinutes: 9 * 60 + 55, returnEndMinutes: 10 * 60 + 55, isTemporarilyClosed: false, sourceUpdatedAt: now)
            ]
        )
        recommendation = recommendationEngine.nextLightningLane(attractions: TripSeed.attractions(), context: context)
        diningRecommendation = diningEngine.recommendations(
            locations: TripSeed.diningLocations(),
            context: DiningContext(
                park: .disneyland,
                currentLand: .adventureland,
                minutesSinceMidnight: 11 * 60 + 30,
                wantsReservation: false
            )
        ).first
    }

    public func confirmBookedRecommendation() {
        guard let recommendation else { return }
        rideState.bookedLightningLane = BookedLightningLane(
            attractionID: recommendation.attraction.id,
            returnStartMinutes: recommendation.returnStartMinutes ?? 10 * 60,
            returnEndMinutes: recommendation.returnEndMinutes ?? 11 * 60
        )
        refreshForDemo()
    }
}
