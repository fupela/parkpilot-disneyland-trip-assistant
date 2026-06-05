public extension TripSeed {
    static func defaultTrip() -> Trip {
        Trip(
            id: "july-2026-disneyland",
            title: "Disneyland Resort July 2026",
            timezone: "America/Los_Angeles",
            party: [
                PartyMember(
                    id: "primary",
                    displayName: "Primary guest",
                    diet: .unrestricted,
                    canEditPlan: true
                ),
                PartyMember(
                    id: "vegetarian",
                    displayName: "Vegetarian guest",
                    diet: .vegetarianDairyEggsOK,
                    canEditPlan: true
                )
            ],
            days: [
                ParkDay(
                    dateISO: "2026-07-10",
                    park: .disneyland,
                    expectedArrivalMinutes: 8 * 60 + 39,
                    expectedCloseMinutes: 1440
                ),
                ParkDay(
                    dateISO: "2026-07-11",
                    park: .californiaAdventure,
                    expectedArrivalMinutes: 8 * 60 + 39,
                    expectedCloseMinutes: 1440
                )
            ],
            lightningLanePolicy: LightningLanePolicy(
                multiPassIncluded: true,
                allowsSinglePass: false
            )
        )
    }

    static func attractions() -> [Attraction] {
        [
            Attraction(id: "indiana-jones", name: "Indiana Jones Adventure", park: .disneyland, land: .adventureland, supportsMultiPass: true, firstTimerPriority: 100, iconicValue: 95, thrillValue: 75),
            Attraction(id: "space-mountain", name: "Space Mountain", park: .disneyland, land: .tomorrowland, supportsMultiPass: true, firstTimerPriority: 98, iconicValue: 96, thrillValue: 80),
            Attraction(id: "matterhorn", name: "Matterhorn Bobsleds", park: .disneyland, land: .fantasyland, supportsMultiPass: true, firstTimerPriority: 92, iconicValue: 98, thrillValue: 70),
            Attraction(id: "big-thunder", name: "Big Thunder Mountain Railroad", park: .disneyland, land: .frontierland, supportsMultiPass: true, firstTimerPriority: 91, iconicValue: 90, thrillValue: 65),
            Attraction(id: "haunted-mansion", name: "Haunted Mansion", park: .disneyland, land: .newOrleansSquare, supportsMultiPass: true, firstTimerPriority: 88, iconicValue: 94, thrillValue: 30),
            Attraction(id: "small-world", name: "it's a small world", park: .disneyland, land: .fantasyland, supportsMultiPass: true, firstTimerPriority: 70, iconicValue: 92, thrillValue: 5),
            Attraction(id: "pirates", name: "Pirates of the Caribbean", park: .disneyland, land: .newOrleansSquare, supportsMultiPass: false, firstTimerPriority: 96, iconicValue: 100, thrillValue: 20),
            Attraction(id: "rise-resistance", name: "Star Wars: Rise of the Resistance", park: .disneyland, land: .galaxysEdge, supportsMultiPass: false, firstTimerPriority: 97, iconicValue: 94, thrillValue: 55),
            Attraction(id: "radiator-springs", name: "Radiator Springs Racers", park: .californiaAdventure, land: .carsLand, supportsMultiPass: false, firstTimerPriority: 100, iconicValue: 98, thrillValue: 70),
            Attraction(id: "guardians", name: "Guardians of the Galaxy - Mission: BREAKOUT!", park: .californiaAdventure, land: .avengersCampus, supportsMultiPass: true, firstTimerPriority: 96, iconicValue: 85, thrillValue: 95),
            Attraction(id: "web-slingers", name: "WEB SLINGERS: A Spider-Man Adventure", park: .californiaAdventure, land: .avengersCampus, supportsMultiPass: true, firstTimerPriority: 89, iconicValue: 78, thrillValue: 25),
            Attraction(id: "incredicoaster", name: "Incredicoaster", park: .californiaAdventure, land: .pixarPier, supportsMultiPass: true, firstTimerPriority: 87, iconicValue: 78, thrillValue: 90),
            Attraction(id: "soarin", name: "Soarin' Around the World", park: .californiaAdventure, land: .grizzlyPeak, supportsMultiPass: true, firstTimerPriority: 84, iconicValue: 80, thrillValue: 35),
            Attraction(id: "toy-story-mania", name: "Toy Story Midway Mania!", park: .californiaAdventure, land: .pixarPier, supportsMultiPass: true, firstTimerPriority: 82, iconicValue: 72, thrillValue: 15),
            Attraction(id: "monsters-inc", name: "Monsters, Inc. Mike & Sulley to the Rescue!", park: .californiaAdventure, land: .hollywoodLand, supportsMultiPass: true, firstTimerPriority: 64, iconicValue: 62, thrillValue: 5)
        ]
    }

    static func diningLocations() -> [DiningLocation] {
        [
            DiningLocation(
                id: "galactic-grill",
                name: "Galactic Grill",
                park: .disneyland,
                land: .tomorrowland,
                serviceType: .quickService,
                supportsMobileOrder: true,
                supportsReservations: false,
                vegetarianRating: 70,
                iconicValue: 55,
                menuItems: [
                    MenuItem(id: "chopped-salad", name: "Chopped Salad", isVegetarian: true, notes: "Mixed lettuce, vegetables, beans, Parmesan, and Italian dressing. Verify current ingredients and preparation day-of."),
                    MenuItem(id: "chicken-sandwich", name: "Crispy Chicken Sandwich", isVegetarian: false, notes: "Good unrestricted option.")
                ]
            ),
            DiningLocation(
                id: "ronto-roasters",
                name: "Ronto Roasters",
                park: .disneyland,
                land: .galaxysEdge,
                serviceType: .quickService,
                supportsMobileOrder: true,
                supportsReservations: false,
                vegetarianRating: 85,
                iconicValue: 88,
                menuItems: [
                    MenuItem(id: "ronto-less-wrap", name: "Ronto-less Garden Wrap", isVegetarian: true, notes: "Strong themed vegetarian quick-service pick. Verify current ingredients and preparation day-of."),
                    MenuItem(id: "ronto-wrap", name: "Ronto Wrap", isVegetarian: false, notes: "Popular unrestricted option.")
                ]
            ),
            DiningLocation(
                id: "bengal-barbecue",
                name: "Bengal Barbecue",
                park: .disneyland,
                land: .adventureland,
                serviceType: .snack,
                supportsMobileOrder: true,
                supportsReservations: false,
                vegetarianRating: 75,
                iconicValue: 82,
                menuItems: [
                    MenuItem(id: "bulgogi-bean-salad", name: "Bulgogi Bean Salad", isVegetarian: true, notes: "Vegetarian-friendly salad option near high-demand rides. Verify current ingredients and preparation day-of."),
                    MenuItem(id: "beef-skewer", name: "Bengal Beef Skewer", isVegetarian: false, notes: "Quick protein snack for unrestricted eater.")
                ]
            ),
            DiningLocation(
                id: "lamplight-lounge",
                name: "Lamplight Lounge",
                park: .californiaAdventure,
                land: .pixarPier,
                serviceType: .tableService,
                supportsMobileOrder: false,
                supportsReservations: true,
                vegetarianRating: 78,
                iconicValue: 92,
                menuItems: [
                    MenuItem(id: "brussels-caesar", name: "Brussels Caesar", isVegetarian: true, notes: "Vegetarian-friendly table-service option. Verify current ingredients and preparation day-of."),
                    MenuItem(id: "impossible-burger", name: "Impossible™ Burger", isVegetarian: true, notes: "Plant-based burger option. Verify current ingredients and preparation day-of."),
                    MenuItem(id: "lobster-nachos", name: "Lobster Nachos", isVegetarian: false, notes: "Iconic unrestricted option.")
                ]
            )
        ]
    }
}
