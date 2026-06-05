import Foundation

public enum Park: String, Codable, CaseIterable, Equatable, Sendable {
    case disneyland
    case californiaAdventure

    public var displayName: String {
        switch self {
        case .disneyland: "Disneyland Park"
        case .californiaAdventure: "Disney California Adventure"
        }
    }
}

public enum Land: String, Codable, Equatable, Sendable {
    case adventureland
    case frontierland
    case newOrleansSquare
    case fantasyland
    case tomorrowland
    case galaxysEdge
    case toontown
    case mainStreet
    case carsLand
    case pixarPier
    case avengersCampus
    case buenaVistaStreet
    case hollywoodLand
    case grizzlyPeak
    case sanFransokyoSquare
    case paradiseGardens
}

public struct LightningLanePolicy: Codable, Equatable, Sendable {
    public var multiPassIncluded: Bool
    public var allowsSinglePass: Bool

    public init(multiPassIncluded: Bool, allowsSinglePass: Bool) {
        self.multiPassIncluded = multiPassIncluded
        self.allowsSinglePass = allowsSinglePass
    }
}

public struct PartyMember: Identifiable, Codable, Equatable, Sendable {
    public enum Diet: String, Codable, Equatable, Sendable {
        case unrestricted
        case vegetarianDairyEggsOK
    }

    public var id: String
    public var displayName: String
    public var diet: Diet
    public var canEditPlan: Bool

    public init(id: String, displayName: String, diet: Diet, canEditPlan: Bool) {
        self.id = id
        self.displayName = displayName
        self.diet = diet
        self.canEditPlan = canEditPlan
    }
}

public struct Trip: Codable, Equatable, Sendable {
    public var id: String
    public var title: String
    public var timezone: String
    public var party: [PartyMember]
    public var days: [ParkDay]
    public var lightningLanePolicy: LightningLanePolicy

    public init(id: String, title: String, timezone: String, party: [PartyMember], days: [ParkDay], lightningLanePolicy: LightningLanePolicy) {
        self.id = id
        self.title = title
        self.timezone = timezone
        self.party = party
        self.days = days
        self.lightningLanePolicy = lightningLanePolicy
    }
}

public struct ParkDay: Identifiable, Codable, Equatable, Sendable {
    public var id: String { dateISO }
    public var dateISO: String
    public var park: Park
    public var expectedArrivalMinutes: Int
    public var expectedCloseMinutes: Int

    public init(dateISO: String, park: Park, expectedArrivalMinutes: Int, expectedCloseMinutes: Int) {
        self.dateISO = dateISO
        self.park = park
        self.expectedArrivalMinutes = expectedArrivalMinutes
        self.expectedCloseMinutes = expectedCloseMinutes
    }
}

public struct Attraction: Identifiable, Codable, Equatable, Sendable {
    public var id: String
    public var name: String
    public var park: Park
    public var land: Land
    public var supportsMultiPass: Bool
    public var firstTimerPriority: Int
    public var iconicValue: Int
    public var thrillValue: Int

    public init(id: String, name: String, park: Park, land: Land, supportsMultiPass: Bool, firstTimerPriority: Int, iconicValue: Int, thrillValue: Int) {
        self.id = id
        self.name = name
        self.park = park
        self.land = land
        self.supportsMultiPass = supportsMultiPass
        self.firstTimerPriority = firstTimerPriority
        self.iconicValue = iconicValue
        self.thrillValue = thrillValue
    }
}

public struct AttractionSignal: Codable, Equatable, Sendable {
    public var attractionID: String
    public var standbyMinutes: Int
    public var returnStartMinutes: Int?
    public var returnEndMinutes: Int?
    public var isTemporarilyClosed: Bool
    public var sourceUpdatedAt: Date

    public init(attractionID: String, standbyMinutes: Int, returnStartMinutes: Int?, returnEndMinutes: Int?, isTemporarilyClosed: Bool, sourceUpdatedAt: Date) {
        self.attractionID = attractionID
        self.standbyMinutes = standbyMinutes
        self.returnStartMinutes = returnStartMinutes
        self.returnEndMinutes = returnEndMinutes
        self.isTemporarilyClosed = isTemporarilyClosed
        self.sourceUpdatedAt = sourceUpdatedAt
    }
}

public struct RideState: Codable, Equatable, Sendable {
    public var completedAttractionIDs: Set<String>
    public var skippedAttractionIDs: Set<String>
    public var bookedLightningLane: BookedLightningLane?
    public var nextEligibleMinutes: Int?

    public init(completedAttractionIDs: Set<String> = [], skippedAttractionIDs: Set<String> = [], bookedLightningLane: BookedLightningLane? = nil, nextEligibleMinutes: Int? = nil) {
        self.completedAttractionIDs = completedAttractionIDs
        self.skippedAttractionIDs = skippedAttractionIDs
        self.bookedLightningLane = bookedLightningLane
        self.nextEligibleMinutes = nextEligibleMinutes
    }
}

public struct BookedLightningLane: Codable, Equatable, Sendable {
    public var attractionID: String
    public var returnStartMinutes: Int
    public var returnEndMinutes: Int

    public init(attractionID: String, returnStartMinutes: Int, returnEndMinutes: Int) {
        self.attractionID = attractionID
        self.returnStartMinutes = returnStartMinutes
        self.returnEndMinutes = returnEndMinutes
    }
}

public struct DiningLocation: Identifiable, Codable, Equatable, Sendable {
    public enum ServiceType: String, Codable, Equatable, Sendable {
        case quickService
        case snack
        case tableService
    }

    public var id: String
    public var name: String
    public var park: Park
    public var land: Land
    public var serviceType: ServiceType
    public var supportsMobileOrder: Bool
    public var supportsReservations: Bool
    public var vegetarianRating: Int
    public var iconicValue: Int
    public var menuItems: [MenuItem]

    public init(id: String, name: String, park: Park, land: Land, serviceType: ServiceType, supportsMobileOrder: Bool, supportsReservations: Bool, vegetarianRating: Int, iconicValue: Int, menuItems: [MenuItem]) {
        self.id = id
        self.name = name
        self.park = park
        self.land = land
        self.serviceType = serviceType
        self.supportsMobileOrder = supportsMobileOrder
        self.supportsReservations = supportsReservations
        self.vegetarianRating = vegetarianRating
        self.iconicValue = iconicValue
        self.menuItems = menuItems
    }
}

public struct MenuItem: Identifiable, Codable, Equatable, Sendable {
    public var id: String
    public var name: String
    public var isVegetarian: Bool
    public var notes: String

    public init(id: String, name: String, isVegetarian: Bool, notes: String) {
        self.id = id
        self.name = name
        self.isVegetarian = isVegetarian
        self.notes = notes
    }
}

public enum AlertKind: String, Codable, Equatable, Sendable {
    case scanInPrompt
    case bookLightningLane
    case nextEligibility
    case diningOpening
    case mobileOrder
    case nearbyStandby
    case entertainment
    case staleData
}

public struct TripAlert: Identifiable, Codable, Equatable, Sendable {
    public var id: String
    public var kind: AlertKind
    public var title: String
    public var body: String
    public var priority: Int

    public init(id: String, kind: AlertKind, title: String, body: String, priority: Int) {
        self.id = id
        self.kind = kind
        self.title = title
        self.body = body
        self.priority = priority
    }
}

public enum TripSeed {}
