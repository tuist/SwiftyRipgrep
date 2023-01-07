// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "SwiftyRipgrep",
	products: [
		.library(
			name: "SwiftyRipgrep",
			targets: ["SwiftyRipgrep"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "SwiftyRipgrep",
			dependencies: ["RustXcframework"])
	]
)
	