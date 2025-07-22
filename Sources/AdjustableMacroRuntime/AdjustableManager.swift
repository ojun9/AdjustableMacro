import SwiftUI
import Combine

#if DEBUG
@MainActor
public final class AdjustableManager: ObservableObject {
    public static let shared = AdjustableManager()
    
    @Published public var values: [String: CGFloat] = [:]
    
    private init() {}
    
    public func set(_ key: String, to value: CGFloat) {
        objectWillChange.send()
        values[key] = value
    }
    
    public func binding(for key: String, default defaultValue: CGFloat) -> Binding<CGFloat> {
        if values[key] == nil {
            Task { @MainActor in
                self.values[key] = defaultValue
            }
        }
        return .init(
            get: { self.values[key] ?? defaultValue },
            set: { self.set(key, to: $0) }
        )
    }
}
#endif
