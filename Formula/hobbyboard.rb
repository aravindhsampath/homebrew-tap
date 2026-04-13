class Hobbyboard < Formula
  desc "Your private visual library curated by AI."
  homepage "https://hobbyboard.aravindh.net"
  version "0.2.1"
  license "MIT"

  # MacOS (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.1/hobbyboard-v0.2.1-aarch64-apple-darwin.tar.gz"
    sha256 "09223ac0a74d93d556ceb9550a1e1a9c3435dbffd9524e72dfee9fba4377e0cb"
  end

  # Linux (x86_64)
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.1/hobbyboard-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ef69783bf3d8f734f7cb9ab08e72637b17d9c7a2fb12271562b0750f3c310c83"
  end

  # Linux (ARM64)
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/aravindhsampath/hobbyboard/releases/download/v0.2.1/hobbyboard-v0.2.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "f318ab194a516695e8fc85846ceff6fd86f147a366783347777ba97b1c869ae7"
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
