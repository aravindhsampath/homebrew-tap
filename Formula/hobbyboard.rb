class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://hobbyboard.aravindh.net"
  version "0.1.4"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.4/hobbyboard-v0.1.4-aarch64-apple-darwin.tar.gz"
    sha256 "e0e70c05c75fef1f797ac68ebb1fa2e8c9433d5b8df3f598eb25ac119563f262"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.4/hobbyboard-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "292e11348b41babc734bff054ff92e20ad81726cb898e16e91c278fbe62dfe4a"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.1.4/hobbyboard-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "a8a65b861d5c9f88c28e08cbf2340057e06d36bfe355776c3f4a21237bee2767"
  end

  depends_on "ffmpeg"
  depends_on "libheif"
  depends_on "aom"
  depends_on "dav1d"

  def install
    bin.install "hobbyboard"
  end

  def post_install
    (var/"hobbyboard").mkpath
    (var/"log/hobbyboard").mkpath
  end

  service do
    run [opt_bin/"hobbyboard"]
    keep_alive crashed: true
    working_dir var/"hobbyboard"
    log_path var/"log/hobbyboard/output.log"
    error_log_path var/"log/hobbyboard/error.log"
    environment_variables PATH: std_service_path_env
  end

  def caveats
    <<~EOS
      Hobbyboard uses an embedded vector index (USearch).
      No external database is required.

      Data directory: #{var}/hobbyboard
      Logs:          #{var}/log/hobbyboard/

      To start hobbyboard as a background service:
        brew services start hobbyboard

      Or run manually:
        hobbyboard

      On first run, open http://localhost:9625 to complete setup.
    EOS
  end

  test do
    system "#{bin}/hobbyboard", "--help"
  end
end
