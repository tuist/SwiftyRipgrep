# SwiftyRipgrep

![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey)
![iOS Badge](https://img.shields.io/badge/iOS-13-green)
![macOS Badge](https://img.shields.io/badge/macOS-11-green)

This repository contains a Swift package that wraps [ripgrep](https://github.com/BurntSushi/ripgrep) to be used programmatically from Apple platforms.

## Usage

SwiftyRipgrep is distributed as a Swift Package. All you need to do is to add the dependency to your project through Xcode or in the `Package.swift` of your package:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/gestaltmd/SwiftyRipgrep.git", from: "13.0.0")
    ],
    ...
)
```

## Development

### System dependencies

- [**cbindgen**](https://github.com/eqrion/cbindgen): cbindgen creates C/C++11 headers for Rust libraries which expose a public C API.
- Ruby


## References

- [From Rust to Swift](https://betterprogramming.pub/from-rust-to-swift-df9bde59b7cd)
- [Grep Crate](https://github.com/BurntSushi/ripgrep/tree/master/crates/grep)
- [Cocoa CPU Architectures](https://docs.elementscompiler.com/Platforms/Cocoa/CpuArchitectures/)
- [swift-create-xcframework GitHub action](https://github.com/marketplace/actions/swift-create-xcframework)
- [XCFrameworks](https://kean.blog/post/xcframeworks-caveats)
