// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "GPassword",
    platforms: [.iOS("8.0")],
    products: [
        .library(name: "GPassword", targets: ["GPassword"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GPassword",
            dependencies: [],
            path: "Source"
        )
    ],
    swiftLanguageVersions: [.v4]
)
