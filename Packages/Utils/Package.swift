// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Utils",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Utils",
      targets: ["Utils"])
  ],
  dependencies: [
    .package(url: "https://github.com/poviolabs/PovioKit", .upToNextMajor(from: "3.0.0")),
    .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.0.0"))
  ],
  targets: [
    .target(
      name: "Utils",
      dependencies: [
        .product(name: "PovioKitCore", package: "PovioKit"),
        .product(name: "KeychainAccess", package: "KeychainAccess")
      ],
      path: "Sources/"
    )
  ]
)
