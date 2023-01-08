#!/usr/bin/env ruby
require 'bundler/setup'
require 'tmpdir'
require "toml"
require "open3"
require "fileutils"
require "debug"
require "rainbow/refinement"
using Rainbow

ENV["SWIFT_BRIDGE_OUT_DIR"] = File.join(__dir__, "../generated")

def run_command(args, cwd: File.join(__dir__, ".."))
  puts "  Running: #{args.join(' ')}".cyan
  stdout, stderr, status = Open3.capture3(*args, chdir: cwd)
  raise StandardError, stderr unless status.success?
end

rust_toolchain_path = File.join(__dir__, "../rust-toolchain.toml")
rust_toolchain = TOML.load_file(rust_toolchain_path)
supported_targets = rust_toolchain["toolchain"]["targets"]

puts "Building the Rust library for all the supported targets".green.bold
supported_targets.each do |target|
  puts "Building for target #{target}"
  args = [
    "cargo", "build",
    "--release",
    "--target", target,
    "-Z", "build-std",
    "-Z", "unstable-options"
  ]
  run_command(args)
end

puts "Creating fat binaries for the supported platforms".green.bold
lipo_config = {
  macos: ["x86_64-apple-darwin", "aarch64-apple-darwin"],
  ios_sim: ["x86_64-apple-ios", "aarch64-apple-ios-sim"],
  ios: ["aarch64-apple-ios"],
  ios_macabi: ["aarch64-apple-ios-macabi", "x86_64-apple-ios-macabi"]
}
fat_binaries = []

lipo_config.each do |platform, architectures|
  puts "Flattening binaries for platform #{platform}"
  fat_binary_path = File.join(__dir__, "..", "target", "universal-#{platform}", "release", "libSwiftyRipgrep.a")
  fat_binaries << fat_binary_path
  FileUtils.mkdir_p(File.dirname(fat_binary_path))
  args = [
    "lipo", "-create",
    *architectures.map { |arch| File.join(__dir__, "..", "target", arch, "release", "libSwiftyRipgrep.a") },
    "-output", fat_binary_path
  ]
  run_command(args)
end

xcframework_path = File.join(__dir__, "../RustXcframework.xcframework")
package_sources_path = File.join(__dir__, "../Sources")
package_swift_path = File.join(__dir__, "../Package.swift")

FileUtils.rm_rf(xcframework_path) if File.exist?(xcframework_path)
FileUtils.rm(package_swift_path) if File.exist?(package_swift_path)

Dir.glob(File.join(package_sources_path, "**/*.swift")).each do |source_file|
  FileUtils.rm(source_file) unless source_file.include?("Public")
end

run_command([
  "swift-bridge-cli", "create-package",
  "--bridges-dir", "./generated",
  "--out-dir", ".",
  "--ios", File.join("target", "universal-ios", "release", "libSwiftyRipgrep.a"),
  "--simulator", File.join("target", "universal-ios_sim", "release", "libSwiftyRipgrep.a"),
  "--macos", File.join("target", "universal-macos", "release", "libSwiftyRipgrep.a"),
  "--mac-catalyst", File.join("target", "universal-ios_macabi", "release", "libSwiftyRipgrep.a"),
  "--name", "SwiftyRipgrep"
])

Dir.glob(File.join(package_sources_path, "**/*.swift")).each do |source_file|
  next if source_file.include?("Public")
  content = File.read(source_file)
  content.gsub!("public", "internal")
  File.write(source_file, content)
end
