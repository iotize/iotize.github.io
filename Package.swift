// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "publisher",
    products: [
        .executable(name: "Publisher", targets: ["Publisher"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "Publisher",
            dependencies: ["Publish"]),
    ]
)
