// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Voiper",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "Voiper", targets: ["Voiper"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Voiper", dependencies: []),
        .testTarget(name: "VoiperTests", dependencies: ["Voiper"]),
    ]
)
