// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftBaSicKit",
    platforms: [.iOS(.v14), .macOS(.v11), .watchOS(.v9), .visionOS(.v1), .tvOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftBaSicKit",
            targets: ["SwiftBaSicKit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftBaSicKit", resources: [.process("FrameworkResources"), .process("Localizable")]),
        .testTarget(
            name: "SwiftBaSicKitTests",
            dependencies: ["SwiftBaSicKit"]),
    ]
)
