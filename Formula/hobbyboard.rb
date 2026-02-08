class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://github.com/aravindhsampath/hobbyboard"
  version "0.1.1"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.1/hobbyboard-v0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "e9cbaff03e1750413f4c3b9493574e4bbde625bd081d351e75c85596120dd886"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.1/hobbyboard-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a8dd00173cf1eb50652da33d6d5630b791f7c931cb7d441feef50c55abd76eef"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.1/hobbyboard-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "351ce89a74f1f5c4f655c971565e798c30f27a10874cfd263eb82812bf7c33bf"
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