import XCTest
@testable import TripCore

final class TripSimulationTests: XCTestCase {
    func testDisneylandDayProducesCoherentFirstTimerActions() {
        let simulator = TripSimulator()
        let actions = simulator.simulateDay(park: .disneyland, startingLand: .adventureland)

        XCTAssertGreaterThanOrEqual(actions.count, 5)
        XCTAssertEqual(actions.first?.kind, .scanIn)
        XCTAssertTrue(actions.contains { $0.title.contains("Indiana Jones") || $0.title.contains("Space Mountain") })
        XCTAssertTrue(actions.contains { $0.kind == .food })
    }

    func testCaliforniaAdventureDayProducesCoherentFirstTimerActions() {
        let simulator = TripSimulator()
        let actions = simulator.simulateDay(park: .californiaAdventure, startingLand: .buenaVistaStreet)
        let radiatorActions = actions.filter { $0.title.contains("Radiator Springs") }

        XCTAssertGreaterThanOrEqual(actions.count, 5)
        XCTAssertEqual(actions.first?.kind, .scanIn)
        XCTAssertFalse(radiatorActions.isEmpty)
        XCTAssertTrue(radiatorActions.allSatisfy { $0.kind != .bookLightningLane })
        XCTAssertTrue(radiatorActions.contains { $0.reason.contains("Cars Land") || $0.reason.contains("Single Pass") })
        XCTAssertTrue(actions.contains { $0.kind == .food })
    }

    func testCaliforniaAdventureSimulationDoesNotBookRadiatorSpringsAsMultiPass() {
        let simulator = TripSimulator()
        let actions = simulator.simulateDay(park: .californiaAdventure, startingLand: .buenaVistaStreet)
        let bookedLightningLaneTitles = actions
            .filter { $0.kind == .bookLightningLane }
            .map(\.title)

        XCTAssertFalse(bookedLightningLaneTitles.contains { $0.contains("Radiator Springs") })
    }
}
