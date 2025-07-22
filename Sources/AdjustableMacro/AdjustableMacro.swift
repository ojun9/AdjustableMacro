@_exported import AdjustableMacroRuntime
import Foundation

/// A macro that injects adjustable properties and behavior into a type.
///
/// When applied to a `View`, it enables automatic support for adjustable UI parameters.
/// Use in conjunction with `#adjust(...)` to bind adjustable values within the body.
///
/// For example:
/// ```swift
/// @Adjustable
/// struct MyView: View {
///   var body: some View {
///     Text("Hello")
///       .padding(#adjust(16))
///   }
/// }
/// ```
@attached(member, names: arbitrary)
public macro Adjustable() = #externalMacro(module: "AdjustableMacroMacros", type: "AdjustableMacro")


/// A macro that returns a `CGFloat` bound to a adjustable value.
///
/// This is used inside `View` modifiers to make values like padding, frame size, or spacing
/// adjustable during development. Requires the enclosing type to be marked with `@Adjustable`.
///
/// For example:
/// ```swift
/// Text("Hello")
///   .padding(#adjust(16))
/// ```
@freestanding(expression)
public macro adjust(_ defaultValue: Double) -> CGFloat = #externalMacro(module: "AdjustableMacroMacros", type: "AdjustMacro")
