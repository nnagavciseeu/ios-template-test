// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenAPI",
    platforms: [
      .iOS(.v16),
      .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OpenAPI",
            targets: ["OpenAPI"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
      .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
      .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0")
    ],
    targets: [
      // Targets are the basic building blocks of a package, defining a module or a test suite.
      // Targets can depend on other targets in this package and products from dependencies.
      .target(
        name: "OpenAPI",
        dependencies: [
          .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
          .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
        ],
        path: "Sources/"
      ),
      .testTarget(
        name: "OpenAPITests",
        dependencies: ["OpenAPI"]
      ),
    ]
)
