class Lsix < Formula
  desc "Shows thumbnails in terminal using sixel graphics"
  homepage "https://github.com/hackerb9/lsix"
  url "https://github.com/hackerb9/lsix/archive/refs/tags/1.9.1.tar.gz"
  sha256 "310e25389da13c19a0793adcea87f7bc9aa8acc92d9534407c8fbd5227a0e05d"
  license "GPL-3.0-only"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6933808648e9cbccc4289852c29d528d8db07c0b43591e3d2fc6546a0ba2f7f9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6933808648e9cbccc4289852c29d528d8db07c0b43591e3d2fc6546a0ba2f7f9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6933808648e9cbccc4289852c29d528d8db07c0b43591e3d2fc6546a0ba2f7f9"
    sha256 cellar: :any_skip_relocation, sonoma:         "6933808648e9cbccc4289852c29d528d8db07c0b43591e3d2fc6546a0ba2f7f9"
    sha256 cellar: :any_skip_relocation, ventura:        "6933808648e9cbccc4289852c29d528d8db07c0b43591e3d2fc6546a0ba2f7f9"
    sha256 cellar: :any_skip_relocation, monterey:       "6933808648e9cbccc4289852c29d528d8db07c0b43591e3d2fc6546a0ba2f7f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ce3811ff3e34633b66d3f7592cbc227256edef0fd04ce57b033e8fa0ebd3ca58"
  end

  depends_on "bash"
  depends_on "imagemagick"

  def install
    bin.install "lsix"
  end

  test do
    output = shell_output "#{bin}/lsix 2>&1"
    assert_match "Error: Your terminal does not report having sixel graphics support.", output
  end
end
