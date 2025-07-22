import SwiftUI
import AdjustableMacro

@Adjustable
struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .padding(#adjust(4))
            .border(.blue)
    }
}
