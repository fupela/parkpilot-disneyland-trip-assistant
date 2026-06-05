import XCTest
@testable import TripCore

final class DiningEngineTests: XCTestCase {
    func testDiningSeedIncludesSpecificVegetarianMenuItems() {
        let locations = TripSeed.diningLocations()
        let items = locations.flatMap(\.menuItems)
        let vegetarianItems = items.filter(\.isVegetarian)
        let vegetarianItemNames = Set(vegetarianItems.map(\.name))

        XCTAssertTrue(vegetarianItemNames.contains("Ronto-less Garden Wrap"))
        XCTAssertTrue(vegetarianItemNames.contains("Bulgogi Bean Salad"))
        XCTAssertTrue(vegetarianItemNames.contains("Brussels Caesar"))
        XCTAssertTrue(vegetarianItemNames.contains("Chopped Salad"))
        XCTAssertTrue(vegetarianItemNames.contains("Impossible™ Burger"))
        XCTAssertFalse(vegetarianItemNames.contains("Potato Skins"))
        XCTAssertFalse(vegetarianItemNames.contains("Pork & Vegetable Skewer"))
        XCTAssertFalse(vegetarianItemNames.contains("Seasonal Vegetable Skewer"))

        let requiredVerificationNote = "Verify current ingredients and preparation day-of."
        vegetarianItems.forEach { item in
            XCTAssertTrue(
                item.notes.contains(requiredVerificationNote),
                "\(item.name) should include day-of verification guidance."
            )
        }

        let knownNonVegetarianItemNames: Set<String> = [
            "Ronto Wrap",
            "Bengal Beef Skewer",
            "Lobster Nachos",
            "Crispy Chicken Sandwich"
        ]

        knownNonVegetarianItemNames.forEach { itemName in
            XCTAssertFalse(vegetarianItemNames.contains(itemName))
        }
    }

    func testDiningEnginePrioritizesNearbyVegetarianSpecificOptions() {
        let engine = DiningEngine()
        let context = DiningContext(
            park: .disneyland,
            currentLand: .galaxysEdge,
            minutesSinceMidnight: 12 * 60,
            wantsReservation: false
        )

        let results = engine.recommendations(locations: TripSeed.diningLocations(), context: context)

        XCTAssertEqual(results.first?.location.id, "ronto-roasters")
        XCTAssertTrue(results.first?.vegetarianItems.map(\.name).contains("Ronto-less Garden Wrap") == true)
        XCTAssertTrue(results.first?.reason.contains("vegetarian") == true)
    }

    func testDiningEngineCanSurfaceTableServiceForReservations() {
        let engine = DiningEngine()
        let context = DiningContext(
            park: .californiaAdventure,
            currentLand: .pixarPier,
            minutesSinceMidnight: 17 * 60,
            wantsReservation: true
        )

        let results = engine.recommendations(locations: TripSeed.diningLocations(), context: context)

        XCTAssertEqual(results.first?.location.id, "lamplight-lounge")
        XCTAssertTrue(results.first?.location.supportsReservations == true)
    }

    func testDiningRecommendationsExposeSpecificVegetarianItems() {
        let engine = DiningEngine()
        let context = DiningContext(
            park: .disneyland,
            currentLand: .adventureland,
            minutesSinceMidnight: 12 * 60,
            wantsReservation: false
        )

        let results = engine.recommendations(locations: TripSeed.diningLocations(), context: context)
        let bengalRecommendation = results.first { $0.location.id == "bengal-barbecue" }

        XCTAssertTrue(bengalRecommendation?.vegetarianItems.map(\.name).contains("Bulgogi Bean Salad") == true)
        XCTAssertTrue(bengalRecommendation?.reason.contains("Bulgogi Bean Salad") == true)
        XCTAssertFalse(bengalRecommendation?.reason.contains("has options") == true)
    }
}
