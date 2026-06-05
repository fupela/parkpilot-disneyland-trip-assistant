import Observation
import SwiftUI

public struct TripRootView: View {
    @Bindable private var model: AppModel

    public init(model: AppModel) {
        self.model = model
    }

    public var body: some View {
        TabView {
            TodayView(model: model)
                .tabItem { Label("Today", systemImage: "sparkles") }
            PlanView(model: model)
                .tabItem { Label("Plan", systemImage: "list.bullet.rectangle") }
            MapView(model: model)
                .tabItem { Label("Map", systemImage: "map") }
            FoodView(model: model)
                .tabItem { Label("Food", systemImage: "fork.knife") }
            AlertsView(model: model)
                .tabItem { Label("Alerts", systemImage: "bell") }
        }
    }
}
