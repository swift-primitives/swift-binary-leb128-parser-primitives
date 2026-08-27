// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-binary-leb128-parser",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Binary LEB128 Parser",
            targets: ["Binary LEB128 Parser"]
        ),
        .library(
            name: "Binary LEB128 Parser Test Support",
            targets: ["Binary LEB128 Parser Test Support"]
        ),
    ],
    dependencies: [

        .package(
            url: "https://github.com/swift-molecules/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-binary-leb128.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Binary LEB128 Parser",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(
                    name: "Binary LEB128 Decode",
                    package: "swift-binary-leb128"
                ),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "Binary LEB128 Parser Test Support",
            dependencies: [
                "Binary LEB128 Parser"
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Binary LEB128 Parser Tests",
            dependencies: [
                "Binary LEB128 Parser",
                "Binary LEB128 Parser Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
