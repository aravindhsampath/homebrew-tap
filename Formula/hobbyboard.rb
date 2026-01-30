class Hobbyboard < Formula
  desc "A self-hosted private Pinterest alternative for organizing media with AI."
  homepage "https://github.com/aravindhsampath/hobbyboard"
  version "0.2.1"
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.1/hobbyboard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ca244b9b8905f1cd24cdc224da12611dd693b6f69c77e1441b5f259719418d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.1/hobbyboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f246fa9a70dd9825fed987e778792d0c7a62f15d95988096fe2aa7925f6c908d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "hobbyboard" if OS.linux? && Hardware::CPU.arm?
    bin.install "hobbyboard" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
