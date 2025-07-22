import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AdjustableMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        #if DEBUG
        let decl: DeclSyntax = """
        @ObservedObject private var _adjustable_observer = AdjustableManager.shared
        """
        return [decl]
        #else
        return []
        #endif
    }
}
