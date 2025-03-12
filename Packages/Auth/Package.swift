// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Auth",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Auth",
      targets: ["Auth"])
  ],
  dependencies: [
    .package(url: "https://github.com/poviolabs/PovioKitAuth", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/auth0/Auth0.swift", .upToNextMajor(from: "2.10.0")),
    .package(path: "Utils")
  ],
  targets: [
    .target(
      name: "Auth",
      dependencies: [
        .product(name: "PovioKitAuthCore", package: "PovioKitAuth"),
        .product(name: "PovioKitAuthApple", package: "PovioKitAuth"),
        .product(name: "PovioKitAuthGoogle", package: "PovioKitAuth"),
        .product(name: "Auth0", package: "Auth0.swift"),
        .product(name: "Utils", package: "Utils")
      ],
      path: "Sources/"
    )
  ]
)
