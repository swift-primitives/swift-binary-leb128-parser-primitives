// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-binary-leb128-parser-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Binary LEB128 Parser Primitives",
            targets: ["Binary LEB128 Parser Primitives"]
        ),
        .library(
            name: "Binary LEB128 Parser Primitives Test Support",
            targets: ["Binary LEB128 Parser Primitives Test Support"]
        ),
    ],
    dependencies: [

        .package(
            url: "https://github.com/swift-primitives/swift-parser-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-binary-leb128-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-byte-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Binary LEB128 Parser Primitives",
            dependencies: [
                .product(name: "Parser Primitives", package: "swift-parser-primitives"),
                .product(
                    name: "Binary LEB128 Decode Primitives",
                    package: "swift-binary-leb128-primitives"
                ),
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
            ]
        ),
        .target(
            name: "Binary LEB128 Parser Primitives Test Support",
            dependencies: [
                "Binary LEB128 Parser Primitives"
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Binary LEB128 Parser Primitives Tests",
            dependencies: [
                "Binary LEB128 Parser Primitives",
                "Binary LEB128 Parser Primitives Test Support",
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
