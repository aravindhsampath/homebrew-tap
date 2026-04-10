class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://hobbyboard.aravindh.net"
  version "0.2.0"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.0/hobbyboard-v0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "12b90bd832edb6fc6980e17c637afcca95d15f9ff8cf2e55322fe0821616b412"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.0/hobbyboard-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "643e95a978b543325bc6de85f60f725f803c5c96958d2c951676b3e7839f873e"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.0/hobbyboard-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "4b7bc7cc8efc635f749b508a1751bc9c83eb8670ccccb3497c2896070c0e69c0"
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
