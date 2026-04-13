class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://hobbyboard.aravindh.net"
  version "0.2.2"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.2/hobbyboard-v0.2.2-aarch64-apple-darwin.tar.gz"
    sha256 "000476f494b741e19f420217813f444f5512aace1878ea4fce94eadf5af8efd5"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.2/hobbyboard-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c4e4857e48b892fc2c55d21eeb8a789de381475c71c0c920f240b6adcfb9713a"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.2/hobbyboard-v0.2.2-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "785b0fe1665d83d18afd3492a2eaeec650c79163f713f6e66761940e095e38ba"
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
