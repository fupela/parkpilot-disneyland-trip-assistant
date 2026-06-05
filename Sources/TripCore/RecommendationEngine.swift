import Foundation

public struct RecommendationContext: Equatable, Sendable {
    public var park: Park
    public var currentMinutes: Int
    public var currentLand: Land?
    public var rideState: RideState
    public var signals: [AttractionSignal]

    public init(park: Park, currentMinutes: Int, currentLand: Land?, rideState: RideState, signals: [AttractionSignal]) {
        self.park = park
        self.currentMinutes = currentMinutes
        self.currentLand = currentLand
        self.rideState = rideState
        self.signals = signals
    }
}

public struct ScoreFactor: Identifiable, Equatable, Sendable {
    public var id: String { label }
    public var label: String
    public var value: Int

    public init(label: String, value: Int) {
        self.label = label
        self.value = value
    }
}

public struct LightningLaneRecommendation: Equatable, Sendable {
    public var attraction: Attraction
    public var score: Int
    public var estimatedMinutesSaved: Int
    public var returnStartMinutes: Int?
    public var returnEndMinutes: Int?
    public var reason: String
    public var factors: [ScoreFactor]
    public var backupAttractionName: String?

    public init(attraction: Attraction, score: Int, estimatedMinutesSaved: Int, returnStartMinutes: Int?, returnEndMinutes: Int?, reason: String, factors: [ScoreFactor], backupAttractionName: String?) {
        self.attraction = attraction
        self.score = score
        self.estimatedMinutesSaved = estimatedMinutesSaved
        self.returnStartMinutes = returnStartMinutes
        self.returnEndMinutes = returnEndMinutes
        self.reason = reason
        self.factors = factors
        self.backupAttractionName = backupAttractionName
    }
}

public struct RecommendationEngine: Sendable {
    public init() {}

    public func nextLightningLane(attractions: [Attraction], context: RecommendationContext) -> LightningLaneRecommendation? {
        let signalsByID = Dictionary(
            context.signals.map { ($0.attractionID, $0) },
            uniquingKeysWith: { _, newer in newer }
        )

        let candidates = attractions.compactMap { attraction -> LightningLaneRecommendation? in
            guard attraction.park == context.park else { return nil }
            guard attraction.supportsMultiPass else { return nil }
            guard !context.rideState.completedAttractionIDs.contains(attraction.id) else { return nil }
            guard !context.rideState.skippedAttractionIDs.contains(attraction.id) else { return nil }
            guard context.rideState.bookedLightningLane?.attractionID != attraction.id else { return nil }
            guard let signal = signalsByID[attraction.id] else { return nil }
            guard !signal.isTemporarilyClosed else { return nil }
            guard signal.standbyMinutes >= 20 else { return nil }

            let saved = max(signal.standbyMinutes - 12, 0)
            let priorityScore = attraction.firstTimerPriority
            let iconicScore = attraction.iconicValue / 2
            let waitSavedScore = min(saved, 90)
            let returnFitScore = returnWindowFitScore(
                currentMinutes: context.currentMinutes,
                returnStartMinutes: signal.returnStartMinutes
            )
            let sellOutRiskScore = signal.returnStartMinutes.map {
                max(0, min(30, ($0 - context.currentMinutes) / 8))
            } ?? 0
            let walkScore = context.currentLand == attraction.land ? 12 : 0
            let total = priorityScore + iconicScore + waitSavedScore + returnFitScore + sellOutRiskScore + walkScore

            var factors = [
                ScoreFactor(label: "First-timer priority", value: priorityScore),
                ScoreFactor(label: "Iconic value", value: iconicScore),
                ScoreFactor(label: "High wait saved", value: waitSavedScore)
            ]
            if walkScore > 0 {
                factors.append(ScoreFactor(label: "Nearby", value: walkScore))
            }
            if sellOutRiskScore > 0 {
                factors.append(ScoreFactor(label: "Return windows moving", value: sellOutRiskScore))
            }

            return LightningLaneRecommendation(
                attraction: attraction,
                score: total,
                estimatedMinutesSaved: saved,
                returnStartMinutes: signal.returnStartMinutes,
                returnEndMinutes: signal.returnEndMinutes,
                reason: "\(attraction.name) is the highest-value Lightning Lane right now and saves about \(saved) minutes.",
                factors: factors,
                backupAttractionName: nil
            )
        }
        .sorted { lhs, rhs in
            if lhs.score == rhs.score {
                return lhs.attraction.firstTimerPriority > rhs.attraction.firstTimerPriority
            }
            return lhs.score > rhs.score
        }

        guard var top = candidates.first else { return nil }
        top.backupAttractionName = candidates.dropFirst().first?.attraction.name
        return top
    }

    private func returnWindowFitScore(currentMinutes: Int, returnStartMinutes: Int?) -> Int {
        guard let returnStartMinutes else { return 0 }
        let delta = returnStartMinutes - currentMinutes
        if delta < 0 { return -40 }
        if delta <= 90 { return 35 }
        if delta <= 180 { return 20 }
        return 5
    }
}
