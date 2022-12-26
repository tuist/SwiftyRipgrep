import PackageDescription

let package = Package(
    name: "SwiftyRipgrep",
    platforms: [
        .macOS(.v10_14), .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftyRipgrep",
            targets: ["SwiftyRipgrep"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SwiftyRipgrep", dependencies: [])
        // .binaryTarget(name: "Ripgrep", path: "./vendor/ripgrep.xcframework")
    ]
)
