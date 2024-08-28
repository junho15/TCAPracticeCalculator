import SwiftUI
import ComposableArchitecture

@main
struct TCAPracticeCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialState: CalculatorFeature.State(),
                reducer: {
                    CalculatorFeature()
                }
            ))
        }
    }
}
