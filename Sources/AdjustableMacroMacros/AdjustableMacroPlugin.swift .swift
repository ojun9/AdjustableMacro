import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct AdjustablePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AdjustableMacro.self, AdjustMacro.self
    ]
}
