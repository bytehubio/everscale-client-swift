// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EverscaleClientSwift",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v11),
        .iOS(SupportedPlatform.IOSVersion.v10)
    ],
    products: [
        .library(name: "EverscaleClientSwift", targets: ["EverscaleClientSwift"]),
    ],
    dependencies: [
        .package(name: "SwiftRegularExpression", url: "https://github.com/nerzh/swift-regular-expression.git", .upToNextMajor(from: "0.2.4")),
        .package(name: "FileUtils", url: "https://github.com/nerzh/SwiftFileUtils", .upToNextMinor(from: "1.3.0")),
        .package(name: "BigInt", url: "https://github.com/bytehubio/BigInt", .exact("5.3.0")),
    ],
    targets: [
        .systemLibrary(name: "CTonSDK", pkgConfig: "libton_client"),
        .target(
            name: "EverscaleClientSwift",
            dependencies: [
                .byName(name: "CTonSDK"),
                .product(name: "SwiftRegularExpression", package: "SwiftRegularExpression"),
                .product(name: "BigInt", package: "BigInt"),
            ]),
        .testTarget(
            name: "EverscaleClientSwiftTests",
            dependencies: [
                .product(name: "SwiftRegularExpression", package: "SwiftRegularExpression"),
                .byName(name: "EverscaleClientSwift"),
                .product(name: "FileUtils", package: "FileUtils"),
                .product(name: "BigInt", package: "BigInt"),
            ]),
    ],
    swiftLanguageVersions: [
        SwiftVersion.v5
    ]
)
