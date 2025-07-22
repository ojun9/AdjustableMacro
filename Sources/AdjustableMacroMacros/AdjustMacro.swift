import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AdjustMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let defaultExpr = node.arguments.first?.expression else {
            throw MacroExpansionError.missingArgument
        }

        let fullFilePath = context.location(of: node)?.file.description.trimmingCharacters(in: .init(charactersIn: "\""))
        let file = fullFilePath?.components(separatedBy: "/").last ?? "unknown"
        let line = context.location(of: node)?.line.description ?? "0"
        let key = "\(file):\(line)"

        #if DEBUG
        let expr: ExprSyntax = """
        AdjustableManager.shared.binding(
            for: \(literal: key),
            default: CGFloat(\(defaultExpr))
        ).wrappedValue
        """
        #else
        let expr: ExprSyntax = "CGFloat(\(defaultExpr))"
        #endif

        return expr
    }
}

enum MacroExpansionError: Error {
    case missingArgument
}
