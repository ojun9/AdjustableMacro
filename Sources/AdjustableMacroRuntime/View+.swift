import SwiftUI

extension View {
    @ViewBuilder
    public func withAdjustableOverlayIfDebug() -> some View {
        #if DEBUG
        self
            .overlay {
                AdjustableShakeTriggerView()
                    .allowsHitTesting(false)
            }
        #else
        self
        #endif
    }
}
