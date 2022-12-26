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
                checksum: "c228997e1855eb7e10b10fe4d4ccd77905a205eba3deb5bdc2853b2beb3081a3"
            )
        ]
)
