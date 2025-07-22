// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "adjustable-macro",
    platforms: [.macOS(.v10_15), .iOS(.v17)],
    products: [
        .library(
            name: "AdjustableMacro",
            targets: ["AdjustableMacro"]
        ),
        .executable(
            name: "AdjustableMacroClient",
            targets: ["AdjustableMacroClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        .macro(
            name: "AdjustableMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "AdjustableMacro",
            dependencies: [
                "AdjustableMacroMacros",
                "AdjustableMacroRuntime"
            ]
        ),
        .target(
            name: "AdjustableMacroRuntime",
            dependencies: []
        ),
        .executableTarget(
            name: "AdjustableMacroClient",
            dependencies: ["AdjustableMacro"]
        ),

        .testTarget(
            name: "AdjustableMacroTests",
            dependencies: [
                "AdjustableMacroMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
