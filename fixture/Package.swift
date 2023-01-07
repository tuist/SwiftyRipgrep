// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "SwiftyRipgrepFixture",
	dependencies: [
        .package(path: "../")
    ],
	targets: [
        .testTarget(name: "SwiftyRipgrepTests", dependencies: ["SwiftyRipgrep"])
    ]
)
