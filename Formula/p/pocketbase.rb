class Pocketbase < Formula
  desc "Open source backend for your next project in 1 file"
  homepage "https://pocketbase.io/"
  url "https://github.com/pocketbase/pocketbase/archive/refs/tags/v0.25.8.tar.gz"
  sha256 "54cbe297798c6875788a87fe9ff38b5d176e76a054f2bcc87a8e51f9fedd9652"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d03f867ad0feb0244da0414426bd6cdedde9a7bc9512cd48fd9eed5bf5dba476"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d03f867ad0feb0244da0414426bd6cdedde9a7bc9512cd48fd9eed5bf5dba476"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d03f867ad0feb0244da0414426bd6cdedde9a7bc9512cd48fd9eed5bf5dba476"
    sha256 cellar: :any_skip_relocation, sonoma:        "a1011e5dd8fc3dd1964179f56347c6c0d8498c0e094d6d9a8af8e5091552f70e"
    sha256 cellar: :any_skip_relocation, ventura:       "a1011e5dd8fc3dd1964179f56347c6c0d8498c0e094d6d9a8af8e5091552f70e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ba87dd4993f9ff7cb64f611c0d1157c9f3d7f0531ffb4ad4e98e3101792c931"
  end

  depends_on "go" => :build

  uses_from_macos "netcat" => :test

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/pocketbase/pocketbase.Version=#{version}"), "./examples/base"
  end

  test do
    assert_match "pocketbase version #{version}", shell_output("#{bin}/pocketbase --version")

    port = free_port
    _, _, pid = PTY.spawn("#{bin}/pocketbase serve --dir #{testpath}/pb_data --http 127.0.0.1:#{port}")
    sleep 5

    system "nc", "-z", "localhost", port

    assert_path_exists testpath/"pb_data", "pb_data directory should exist"
    assert_predicate testpath/"pb_data", :directory?, "pb_data should be a directory"

    assert_path_exists testpath/"pb_data/data.db", "pb_data/data.db should exist"
    assert_predicate testpath/"pb_data/data.db", :file?, "pb_data/data.db should be a file"

    assert_path_exists testpath/"pb_data/auxiliary.db", "pb_data/auxiliary.db should exist"
    assert_predicate testpath/"pb_data/auxiliary.db", :file?, "pb_data/auxiliary.db should be a file"
  ensure
    Process.kill "TERM", pid
  end
end
