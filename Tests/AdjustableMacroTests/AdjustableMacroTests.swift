import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(AdjustableMacroMacros)
import AdjustableMacroMacros

@MainActor
let testMacros: [String: Macro.Type] = [
    "adjust": AdjustMacro.self,
    "Adjustable": AdjustableMacro.self,
]
#endif

@MainActor
final class AdjustMacroTests: XCTestCase {

    func testAdjustMacro_Debug() throws {
#if canImport(AdjustableMacroMacros)
        assertMacroExpansion(
            """
            #adjust(12.0)
            """,
            expandedSource: """
            AdjustableManager.shared.binding(
                for: "macro_test.swift:1",
                default: CGFloat(12.0)
            ).wrappedValue
            """,
            macros: testMacros,
            indentationWidth: .spaces(4)
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func testAdjustableMacro_Debug() throws {
#if canImport(AdjustableMacroMacros)
        assertMacroExpansion(
            """
            @Adjustable
            struct MyView: View {
            }
            """,
            expandedSource: """
            struct MyView: View {
                @ObservedObject private var _adjustable_observer = AdjustableManager.shared
            }
            """,
            macros: testMacros,
            indentationWidth: .spaces(4)
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func testAdjustMacro_MissingArgument() throws {
#if canImport(AdjustableMacroMacros)
        XCTAssertThrowsError(
            try assertMacroExpansion(
                """
                #adjust()
                """,
                expandedSource: "",
                macros: testMacros
            )
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
