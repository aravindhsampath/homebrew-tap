class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://github.com/aravindhsampath/hobbyboard"
  version "0.1.2"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard-v0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "0831c209d0164d11873185a059c4432d111729ff8c011405b37aa4b93e4d3b7a"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b52bfb555cda97b8ba79d5072e140582ecff09609a7894e97f002a6cd60a617f"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "010364b42fe6037aa517283124157c6d0133622f3c276573855b60e22e267fea"
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