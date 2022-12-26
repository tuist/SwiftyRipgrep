// swift-tools-version:5.3
import PackageDescription
import Foundation
let package = Package(
        name: "SwiftyRipgrep",
        platforms: [
            .iOS(.v13),
            .macOS(.v11)
        ],
        products: [
            .library(
                name: "SwiftyRipgrep",
                targets: ["SwiftyRipgrep"]),
        ],
        targets: [
            .target(
                name: "SwiftyRipgrep",
                dependencies: ["Ripgrep"]),
            .binaryTarget(name: "Ripgrep", path: "./vendor/Ripgrep.xcframework")
        ]
)
