import Foundation

public protocol TripNotifier: Sendable {
    func send(_ alert: TripAlert) async
}

public actor FakeTripNotifier: TripNotifier {
    private var alerts: [TripAlert] = []

    public init() {}

    public func send(_ alert: TripAlert) async {
        alerts.append(alert)
    }

    public func sentAlerts() async -> [TripAlert] {
        alerts
    }
}

public protocol ScanInPrompting: Sendable {
    func shouldPromptForScanIn(isNearGate: Bool, alreadyConfirmed: Bool) -> Bool
}

public struct GeofenceScanInPrompt: ScanInPrompting {
    public init() {}

    public func shouldPromptForScanIn(isNearGate: Bool, alreadyConfirmed: Bool) -> Bool {
        isNearGate && !alreadyConfirmed
    }
}
