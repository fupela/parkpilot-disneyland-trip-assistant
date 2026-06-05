import Foundation

public struct DisneyHandoff: Equatable, Sendable {
    public var actionTitle: String
    public var targetURL: URL?
    public var manualInstructions: String

    public init(actionTitle: String, targetURL: URL?, manualInstructions: String) {
        self.actionTitle = actionTitle
        self.targetURL = targetURL
        self.manualInstructions = manualInstructions
    }

    public static func lightningLane(attractionName: String) -> DisneyHandoff {
        DisneyHandoff(
            actionTitle: "Open Disneyland App",
            targetURL: URL(string: "https://disneyland.disney.go.com/guest-services/download-disneyland-mobile-app/"),
            manualInstructions: "Open the Disneyland app. Go to Lightning Lane Multi Pass. Choose \(attractionName). Verify both guests. Confirm the final booking inside Disney."
        )
    }

    public static func dining(locationName: String) -> DisneyHandoff {
        DisneyHandoff(
            actionTitle: "Open Disney Dining",
            targetURL: URL(string: "https://disneyland.disney.go.com/dining/"),
            manualInstructions: "Open Disney dining. Search \(locationName). Choose the available time. Verify both guests. Confirm the reservation inside Disney."
        )
    }
}
