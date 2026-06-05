import XCTest
@testable import TripCore

final class TripStoreTests: XCTestCase {
    func testBothUsersCanUpdateLowRiskStateWithLastWriteWins() async {
        let store = InMemoryTripStore(initial: SharedTripState(trip: TripSeed.defaultTrip()))

        await store.markCompleted(attractionID: "pirates", actorID: "user")
        await store.markCompleted(attractionID: "haunted-mansion", actorID: "girlfriend")

        let state = await store.currentState()
        XCTAssertTrue(state.rideState.completedAttractionIDs.contains("pirates"))
        XCTAssertTrue(state.rideState.completedAttractionIDs.contains("haunted-mansion"))
    }

    func testImportantBookingStateRequiresExplicitReplacement() async {
        let store = InMemoryTripStore(initial: SharedTripState(trip: TripSeed.defaultTrip()))

        await store.setBookedLightningLane(
            BookedLightningLane(attractionID: "indiana-jones", returnStartMinutes: 10 * 60, returnEndMinutes: 11 * 60),
            actorID: "user"
        )
        await store.setBookedLightningLane(
            BookedLightningLane(attractionID: "space-mountain", returnStartMinutes: 11 * 60, returnEndMinutes: 12 * 60),
            actorID: "girlfriend"
        )

        let state = await store.currentState()
        XCTAssertEqual(state.rideState.bookedLightningLane?.attractionID, "space-mountain")
        XCTAssertEqual(state.lastImportantChangeActorID, "girlfriend")
    }

    func testFreshnessDefaultsUnavailableAndCanBecomeStale() async {
        let store = InMemoryTripStore(initial: SharedTripState(trip: TripSeed.defaultTrip()))

        var state = await store.currentState()
        XCTAssertEqual(state.freshness, .unavailable)

        await store.setFreshness(.stale(minutesOld: 18))

        state = await store.currentState()
        XCTAssertEqual(state.freshness, .stale(minutesOld: 18))
    }

    func testDisneyHandoffNeverRequiresCredentials() {
        let handoff = DisneyHandoff.lightningLane(attractionName: "Indiana Jones Adventure")

        XCTAssertEqual(handoff.actionTitle, "Open Disneyland App")
        XCTAssertFalse(handoff.manualInstructions.contains("password"))
        XCTAssertTrue(handoff.manualInstructions.contains("Confirm the final booking inside Disney"))
    }

    func testFakeNotifierRecordsActionableAlerts() async {
        let notifier = FakeTripNotifier()
        let alert = TripAlert(
            id: "scan-in",
            kind: .scanInPrompt,
            title: "Did both of you scan in?",
            body: "Confirm to start active recommendations.",
            priority: 100
        )

        await notifier.send(alert)

        let sent = await notifier.sentAlerts()
        XCTAssertEqual(sent, [alert])
    }

    func testDisneyHandoffDoesNotSuggestAutomaticBackgroundBooking() {
        let handoff = DisneyHandoff.lightningLane(attractionName: "Indiana Jones Adventure")
        let manualInstructions = handoff.manualInstructions.lowercased()
        let bannedWords = ["automatic", "background", "bot", "credential"]

        for word in bannedWords {
            XCTAssertNil(
                manualInstructions.range(of: #"\b\#(word)\b"#, options: .regularExpression),
                "Handoff instructions should not suggest \(word)-based booking"
            )
        }
    }

    func testGeofenceScanInPromptOnlyPromptsNearGateBeforeConfirmation() {
        let prompt = GeofenceScanInPrompt()

        XCTAssertTrue(prompt.shouldPromptForScanIn(isNearGate: true, alreadyConfirmed: false))
        XCTAssertFalse(prompt.shouldPromptForScanIn(isNearGate: false, alreadyConfirmed: false))
        XCTAssertFalse(prompt.shouldPromptForScanIn(isNearGate: true, alreadyConfirmed: true))
        XCTAssertFalse(prompt.shouldPromptForScanIn(isNearGate: false, alreadyConfirmed: true))
    }
}
