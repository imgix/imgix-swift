// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "ImgixSwift",
    products: [
        .library(name: "ImgixSwift", targets: ["ImgixSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/CommonCrypto", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ImgixSwift",
            dependencies: ["CommonCrypto"]),
        .testTarget(
            name: "ImgixSwiftTests",
            dependencies: ["ImgixSwift"]),
    ]
)
