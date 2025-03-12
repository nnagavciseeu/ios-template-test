// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "PovioMacro",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: "PovioMacro",
      targets: ["PovioMacro"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0")
  ],
  targets: [
    .macro(
      name: "PovioMacroMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .target(name: "PovioMacro", dependencies: ["PovioMacroMacros"]),
    .testTarget(
      name: "PovioMacroTests",
      dependencies: [
        "PovioMacroMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
      ]
    )
  ]
)
