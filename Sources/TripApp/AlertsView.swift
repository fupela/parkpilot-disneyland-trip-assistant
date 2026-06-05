import Observation
import SwiftUI

public struct AlertsView: View {
    @Bindable var model: AppModel

    public init(model: AppModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            List(model.alerts) { alert in
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(alert.title)
                            .font(.headline)
                            .foregroundStyle(ParkStyle.ink)
                        Spacer(minLength: 12)
                        Text("P\(alert.priority)")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(ParkStyle.blue)
                    }
                    Text(alert.body)
                        .font(.subheadline)
                        .foregroundStyle(ParkStyle.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 5)
            }
            .listStyle(.plain)
            .navigationTitle("Alerts")
            .background(ParkStyle.surface)
        }
    }
}
