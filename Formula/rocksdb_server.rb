class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.3.5"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.3.5/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "9cb75e03ce840cb108a1c98f43215f3c9e9e41b245029478e26abc632c4ece38"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.3.5/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "7dffc84d2440b5267060d5a2957e6fcc4f534496dcdc1167ab7b08f1ad373bd5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.3.5/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "70aa05992b533c40747f6b345299a77f26e5da3b0c953f35ffb17504c58a3515"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.3.5/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "a9b1b6e3faa846c73b72985a19055265e2adddf0f642cdc065ca2880d762f0a4"
    end
  end

  def install
    bin.install "rocksdb_server"

    # Make the binary executable
    chmod "+x", "#{bin}/rocksdb_server"

    # Clear extended attributes and sign the binary (macOS only)
    if OS.mac?
      ohai "During the installation process, you will be prompted to enter your password."
      ohai "This is necessary to make the binary executable and to self-sign the application"
      ohai "using the `xattr` and `codesign` commands to ensure it runs correctly on macOS."

      system "/usr/bin/xattr", "-cr", "#{bin}/rocksdb_server"
      system "/usr/bin/codesign", "--force", "--deep", "--sign", "-", "#{bin}/rocksdb_server"
    end
  end

  service do
    run [opt_bin/"rocksdb_server"]
    keep_alive true
    working_dir var
    log_path var/"log/rocksdb_server.log"
    error_log_path var/"log/rocksdb_server.log"
    run_type :immediate
  end

  test do
    system "#{bin}/rocksdb_server", "--version"
  end
end
