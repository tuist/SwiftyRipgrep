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
            .binaryTarget(
                name: "Ripgrep",
                url: "https://github.com/chimerarun/SwiftyRipgrep/releases/download/13.0.0/Ripgrep.xcframework.zip",
                checksum: "e71af29f3d66fb6338b9f12de049252891ebe663ad4bc168d3333862f156760e"
            )
        ]
)
