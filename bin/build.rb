#!/usr/bin/env ruby
require 'bundler/setup'
require 'tmpdir'
require "toml"
require "open3"
require "fileutils"
require "debug"
require "rainbow/refinement"
using Rainbow

def run_command(args, cwd: File.join(__dir__, ".."))
  puts "  Running: #{args.join(' ')}".cyan
  stdout, stderr, status = Open3.capture3(*args, chdir: cwd)
  raise StandardError, stderr unless status.success?
end

rust_toolchain_path = File.join(__dir__, "../rust-toolchain.toml")
rust_toolchain = TOML.load_file(rust_toolchain_path)
supported_targets = rust_toolchain["toolchain"]["targets"]

args = [
  "cbindgen",
  "--lang", "c",
  "--output", File.join(__dir__, "../include/ripgrep.h")
]
run_command(args)

Dir.mktmpdir do |tmp_dir|
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
    ios_macabi: ["aarch64-apple-ios-macabi", "x86_64-apple-ios-macabi"],
    # watchos_sim: ["aarch64-apple-watchos-sim", "x86_64-apple-watchos-sim"],
    # watchos: ["arm64_32-apple-watchos"]
  }
  fat_binaries = []

  lipo_config.each do |platform, architectures|
    puts "Flattening binaries for platform #{platform}"
    fat_binary_path = File.join(tmp_dir, platform.to_s, "libripgrep.a")
    fat_binaries << fat_binary_path
    FileUtils.mkdir_p(File.dirname(fat_binary_path))
    args = [
      "lipo", "-create",
      *architectures.map { |arch| File.join(__dir__, "..", "target", arch, "release", "libripgrep.a") },
      "-output", fat_binary_path
    ]
    run_command(args)
  end

  puts "Building xcframework".green.bold
  xcframework_path = File.join(tmp_dir, "./Ripgrep.xcframework")
  args = [
    "xcodebuild", "-create-xcframework",
    *fat_binaries.map { |path| ["-library", path, "-headers", File.join(__dir__, "../include")] }.flatten,
    "-output", xcframework_path
  ]
  run_command(args)

  puts "Creating a zip with the .xcframework".green.bold
  zip_path = File.join(__dir__, "../Ripgrep.xcframework.zip")
  args = [
    "zip",
    "-r", zip_path,
    xcframework_path
  ]
  run_command(args, cwd: File.dirname(xcframework_path))
  sha256 = `openssl dgst -sha256 #{zip_path}`.split(" ").last
  puts "SHA256: #{sha256}"
end

