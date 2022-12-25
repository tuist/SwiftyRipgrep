#!/usr/bin/env ruby
require 'bundler/setup'
require 'tmpdir'
require "toml"
require "open3"
require "fileutils"
require "rainbow/refinement"
using Rainbow

rust_toolchain_path = File.join(__dir__, "../rust-toolchain.toml")
rust_toolchain = TOML.load_file(rust_toolchain_path)
supported_targets = rust_toolchain["toolchain"]["targets"]

Dir.mktmpdir do |tmp_dir|
  puts "Building the Rust library for all the supported targets".green.bold
  supported_targets.each do |target|
    puts "Building for target #{target}"
    out_dir = File.join(tmp_dir, target)
    FileUtils.mkdir_p(out_dir)
    args = [
      "cargo", "build",
      "--release",
      "--target", target,
      "--out-dir", out_dir,
      "-Z", "unstable-options"
    ]
    puts "  Running: #{args.join(' ')}".cyan
    stdout, stderr, status = Open3.capture3(*args)
    raise StandardError, stderr unless status.success?
  end
end
