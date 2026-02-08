class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://github.com/aravindhsampath/hobbyboard"
  version "0.1.3"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.3/hobbyboard-v0.1.3-aarch64-apple-darwin.tar.gz"
    sha256 "3b4f6a49b01d53f2e4ece64ca143f45ba1c98d0975343bb92bda482c5d65353f"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.3/hobbyboard-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d0dde49acf01a2c9cbb285a7f3f8667c1e8300c127df3b28f6baf2f368106554"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.3/hobbyboard-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "7ac816bf77042e2df03624b635deaf98e2466e8118a6d97d94cf3f6a1700e97f"
  end

  depends_on "ffmpeg"
  depends_on "libheif"
  depends_on "aom"
  depends_on "dav1d"

  def install
    bin.install "hobbyboard"
  end

  def caveats
    <<~EOS
      Hobbyboard requires a vector database (Qdrant) to function.
      The easiest way to run Qdrant is via Docker:
        docker run -d -p 6333:6333 -p 6334:6334 -v $(pwd)/qdrant_storage:/qdrant/storage:z qdrant/qdrant
    EOS
  end

  test do
    system "#{bin}/hobbyboard", "--help"
  end
end
