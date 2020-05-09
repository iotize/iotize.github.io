// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "publisher",
    products: [
        .executable(name: "Publisher", targets: ["Publisher"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.0.1")),
    ],
    targets: [
        .target(
            name: "Publisher",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .priduct(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
    ]
)
