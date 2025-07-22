import SwiftUI

#if DEBUG
struct AdjustablePanelView: View {
    @ObservedObject var manager = AdjustableManager.shared

    public init() {}

    public var body: some View {
        ScrollView {
            VStack {
                ForEach(manager.values.keys.sorted(), id: \.self) { key in
                    if let value = manager.values[key] {
                        VStack(alignment: .leading) {
                            Text("\(key): \(value, specifier: "%.1f")")
                            Slider(
                                value: manager.binding(for: key, default: 8),
                                in: 0...40
                            )
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding()
        }
    }
}
#endif

