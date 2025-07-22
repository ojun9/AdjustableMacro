# AdjustableMacro
**AdjustableMacro** is a Swift macro library that allows real-time adjustment of UI property values during SwiftUI development.
With the `#adjust()` macro, you can tweak numeric values such as `.padding()`, `.offset()`, and `.frame()` in real time without rebuilding your app.

![Example](Assets/example.gif)

## Features
- Enables real-time editing of numeric values via `#adjust()`
- Injects adjustment overlay automatically into views marked with `@Adjustable`
- Displays a slider-based overlay when a shake gesture is detected and `.withAdjustableOverlayIfDebug()` is applied
- Expands to literal values in release builds, ensuring no runtime overhead

## Installation

```swift
.package(url: "https://github.com/ojun9/AdjustableMacro.git", from: "0.0.1")
```

## Usage
To enable the overlay, apply `.withAdjustableOverlayIfDebug()` at the app entry point.

```swift
import AdjustableMacro

@main
struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .withAdjustableOverlayIfDebug()
    }
  }
}
```

Then, mark the target view with @Adjustable and wrap any numeric value with `#adjust()`.

```swift
import AdjustableMacro
import SwiftUI

@Adjustable
struct ContentView: View {
  var body: some View {
    Text("Hello")
      .padding(#adjust(12))
  }
}
```

### Triggering the Adjustment UI
Once `.withAdjustableOverlayIfDebug()` is applied, the adjustment UI (with sliders) can be triggered as follows:

- On a physical device: shake the device
- On the simulator: press `Control + Command + Z`

### When using `sheet` or `fullScreenCover`
If you present another view using sheet, fullScreenCover, or similar modifiers, you must also apply `.withAdjustableOverlayIfDebug()` to the presented view.


```swift
.sheet(isPresented: $isPresented) {
  DetailView()
    .withAdjustableOverlayIfDebug()
}
```

## Requirements
- iOS 17.0+
- Swift 6.0+
