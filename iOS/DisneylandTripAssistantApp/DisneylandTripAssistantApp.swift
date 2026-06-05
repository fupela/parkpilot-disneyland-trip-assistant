import SwiftUI
import TripApp

@main
struct DisneylandTripAssistantApp: App {
    @State private var model = AppModel()

    var body: some Scene {
        WindowGroup {
            TripRootView(model: model)
        }
    }
}
