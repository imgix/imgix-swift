// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ImgixSwift",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9_2)
    ],
    products: [
        .library(
            name: "ImgixSwift",
            targets: ["ImgixSwift"]),
    ],
    targets: [
        .target(
            name: "ImgixSwift",
            path: "Sources"),
        .testTarget(
            name: "ImgixSwiftTests",
            path: "ImgixSwiftTests")
    ],
    swiftLanguageVersions: [.v5]
)

