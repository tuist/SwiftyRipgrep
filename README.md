# SwiftyRipgrep

[![SwiftyRipgrep](https://github.com/gestaltmd/SwiftyRipgrep/actions/workflows/SwiftyRipgrep.yml/badge.svg)](https://github.com/gestaltmd/SwiftyRipgrep/actions/workflows/SwiftyRipgrep.yml)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey)
![iOS Badge](https://img.shields.io/badge/iOS-13-green)
![macOS Badge](https://img.shields.io/badge/macOS-11-green)

This repository contains a Swift package that wraps [ripgrep](https://github.com/BurntSushi/ripgrep) to be used programmatically in iOS (device and simulator) and macOS.

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

> **Version:** The version of SwiftyRipgrep aligns with the version of [Ripgrep](https://github.com/BurntSushi/ripgrep) wrapped so version 13.0.0 indicates that the Swift package is using the same version of Ripgrep.

## Development

### System dependencies

We recommend the usage of [asdf](https://asdf-vm.com/) to install the dependencies necessary to contribute to this project:

- [Ruby](https://www.ruby-lang.org/en/) 3.1.2
- [Rust](https://rust.sh/)
- [swift-bridge-cli](https://github.com/chinedufn/swift-bridge)

### Generate the Swift Package

The project uses [swift-bridge](https://chinedufn.github.io/swift-bridge/index.html), a Rust tool that leverages macros and other build-time tools to generate the Swift Package from the Rust code. If you change the Rust code or update Cargo dependencies you'll have to run `bin/generate.rb`. The script will update the `Package.swift` and the content under `Sources` and generate a `RustXcframework.xcframework` directory at the root.

### Testing the generated Swift package

The repository contains a Swift package under `fixture` that contains a tests target to test the public interface of the `SwiftyRipgrep` package generated at the root. You can run the tests by running `swift test --package-path ./fixture`

## References

- [From Rust to Swift](https://betterprogramming.pub/from-rust-to-swift-df9bde59b7cd)
- [Grep Crate](https://github.com/BurntSushi/ripgrep/tree/master/crates/grep)
- [Cocoa CPU Architectures](https://docs.elementscompiler.com/Platforms/Cocoa/CpuArchitectures/)
- [swift-create-xcframework GitHub action](https://github.com/marketplace/actions/swift-create-xcframework)
- [XCFrameworks](https://kean.blog/post/xcframeworks-caveats)
- [Recipe for Calling Swift Closures from Asynchronous Rust Code](https://www.nickwilcox.com/blog/recipe_swift_rust_callback/)
- [Building and Deploying a Rust library on iOS](https://mozilla.github.io/firefox-browser-architecture/experiments/2017-09-06-rust-on-ios.html)
- [The swift-bridge book](https://chinedufn.github.io/swift-bridge/)
