// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JTFloatingButton",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "JTFloatingButton",
            targets: ["JTFloatingButton"]
        ),
    ],
    targets: [
        .target(
            name: "JTFloatingButton",
            path: "./Sources/JTFloatingButton"
        ),

    ]
)
