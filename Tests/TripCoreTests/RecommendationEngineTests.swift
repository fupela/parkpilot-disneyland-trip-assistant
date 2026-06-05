import Foundation
import XCTest
@testable import TripCore

final class RecommendationEngineTests: XCTestCase {
    func testTripSeedHasTwoOneParkDays() {
        let trip = TripSeed.defaultTrip()

        XCTAssertEqual(trip.party.count, 2)
        XCTAssertEqual(trip.days.map(\.park), [.disneyland, .californiaAdventure])
        XCTAssertEqual(trip.days.map(\.dateISO), ["2026-07-10", "2026-07-11"])
        XCTAssertEqual(trip.days.map(\.expectedArrivalMinutes), [8 * 60 + 39, 8 * 60 + 39])
        XCTAssertTrue(trip.lightningLanePolicy.multiPassIncluded)
        XCTAssertFalse(trip.lightningLanePolicy.allowsSinglePass)
    }

    func testFirstTimerAttractionsIncludeDemandHeadlinersForBothParks() {
        let attractions = TripSeed.attractions()
        let names = Set(attractions.map(\.name))

        XCTAssertTrue(names.contains("Indiana Jones Adventure"))
        XCTAssertTrue(names.contains("Space Mountain"))
        XCTAssertTrue(names.contains("Matterhorn Bobsleds"))
        XCTAssertTrue(names.contains("Radiator Springs Racers"))
        XCTAssertTrue(names.contains("WEB SLINGERS: A Spider-Man Adventure"))
        XCTAssertTrue(names.contains("Guardians of the Galaxy - Mission: BREAKOUT!"))
    }

    func testRadiatorSpringsRacersIsSinglePassOnly() {
        XCTAssertEqual(TripSeed.attractions().first { $0.id == "radiator-springs" }?.supportsMultiPass, false)
    }

    func testRecommendationPrefersHighValueLightningLaneOverWalkOn() {
        let engine = RecommendationEngine()
        let now = Date(timeIntervalSince1970: 1_788_580_800)
        let context = RecommendationContext(
            park: .disneyland,
            currentMinutes: 8 * 60 + 45,
            currentLand: .adventureland,
            rideState: RideState(),
            signals: [
                AttractionSignal(attractionID: "indiana-jones", standbyMinutes: 75, returnStartMinutes: 10 * 60 + 15, returnEndMinutes: 11 * 60 + 15, isTemporarilyClosed: false, sourceUpdatedAt: now),
                AttractionSignal(attractionID: "small-world", standbyMinutes: 5, returnStartMinutes: 9 * 60 + 15, returnEndMinutes: 10 * 60, isTemporarilyClosed: false, sourceUpdatedAt: now)
            ]
        )

        let result = engine.nextLightningLane(attractions: TripSeed.attractions(), context: context)

        XCTAssertEqual(result?.attraction.id, "indiana-jones")
        XCTAssertTrue(result?.reason.contains("saves about") == true)
        XCTAssertTrue(result?.factors.contains(where: { $0.label == "High wait saved" }) == true)
    }

    func testRecommendationSkipsClosedAndCompletedAttractions() {
        let engine = RecommendationEngine()
        let now = Date(timeIntervalSince1970: 1_788_580_800)
        let context = RecommendationContext(
            park: .disneyland,
            currentMinutes: 10 * 60,
            currentLand: .tomorrowland,
            rideState: RideState(completedAttractionIDs: ["space-mountain"]),
            signals: [
                AttractionSignal(attractionID: "space-mountain", standbyMinutes: 90, returnStartMinutes: 12 * 60, returnEndMinutes: 13 * 60, isTemporarilyClosed: false, sourceUpdatedAt: now),
                AttractionSignal(attractionID: "indiana-jones", standbyMinutes: 80, returnStartMinutes: 12 * 60, returnEndMinutes: 13 * 60, isTemporarilyClosed: true, sourceUpdatedAt: now),
                AttractionSignal(attractionID: "matterhorn", standbyMinutes: 45, returnStartMinutes: 11 * 60, returnEndMinutes: 12 * 60, isTemporarilyClosed: false, sourceUpdatedAt: now)
            ]
        )

        let result = engine.nextLightningLane(attractions: TripSeed.attractions(), context: context)

        XCTAssertEqual(result?.attraction.id, "matterhorn")
    }

    func testRecommendationDoesNotSuggestSinglePassAttractions() {
        let engine = RecommendationEngine()
        let now = Date(timeIntervalSince1970: 1_788_580_800)
        let context = RecommendationContext(
            park: .californiaAdventure,
            currentMinutes: 10 * 60,
            currentLand: .avengersCampus,
            rideState: RideState(),
            signals: [
                AttractionSignal(attractionID: "radiator-springs", standbyMinutes: 140, returnStartMinutes: 11 * 60, returnEndMinutes: 12 * 60, isTemporarilyClosed: false, sourceUpdatedAt: now),
                AttractionSignal(attractionID: "guardians", standbyMinutes: 45, returnStartMinutes: 11 * 60 + 15, returnEndMinutes: 12 * 60 + 15, isTemporarilyClosed: false, sourceUpdatedAt: now)
            ]
        )

        let result = engine.nextLightningLane(attractions: TripSeed.attractions(), context: context)

        XCTAssertNotEqual(result?.attraction.id, "radiator-springs")
        XCTAssertEqual(result?.attraction.id, "guardians")
    }
}
