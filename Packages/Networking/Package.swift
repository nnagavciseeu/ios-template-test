// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Networking",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Networking",
      targets: ["Networking"])
  ],
  dependencies: [
    .package(url: "https://github.com/poviolabs/PovioKit", .upToNextMajor(from: "3.0.0")),
    .package(url: "https://github.com/getsentry/sentry-cocoa", .upToNextMajor(from: "8.0.0")),
    .package(url: "https://github.com/ashleymills/Reachability.swift", .upToNextMajor(from: "5.0.0")),
    .package(path: "Auth"),
    .package(path: "PovioMacro")
  ],
  targets: [
    .target(
      name: "Networking",
      dependencies: [
        .product(name: "PovioKitCore", package: "PovioKit"),
        .product(name: "PovioKitNetworking", package: "PovioKit"),
        .product(name: "Reachability", package: "Reachability.swift"),
        .product(name: "Sentry", package: "sentry-cocoa"),
        .product(name: "Auth", package: "Auth"),
        .product(name: "PovioMacro", package: "PovioMacro")
      ],
      path: "Sources/"
    )
  ]
)
