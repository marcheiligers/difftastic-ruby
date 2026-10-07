# frozen_string_literal: true

require_relative "test_helper"

class PlatformTest < Minitest::Spec
	it "uses the Ruby platform outside JRuby" do
		platform = Difftastic.platform(
			ruby_platform: Gem::Platform.new("x86_64-linux"),
			host_cpu: "ignored",
			host_os: "ignored"
		)

		assert_equal "x86_64-linux", platform
	end

	it "uses the native JVM host on Apple Silicon JRuby" do
		platform = Difftastic.platform(
			ruby_platform: Gem::Platform.new("universal-java"),
			host_cpu: "arm64",
			host_os: "darwin"
		)

		assert_equal "arm64-darwin", platform
	end

	it "normalizes JVM architecture names" do
		platform = Difftastic.platform(
			ruby_platform: Gem::Platform.new("universal-java"),
			host_cpu: "amd64",
			host_os: "linux-gnu"
		)

		assert_equal "x86_64-linux", platform
	end

	it "uses the upstream aarch64 binary for arm64 Linux JVMs" do
		platform = Difftastic.platform(
			ruby_platform: Gem::Platform.new("universal-java"),
			host_cpu: "arm64",
			host_os: "linux"
		)

		assert_equal "aarch64-linux", platform
	end
end
