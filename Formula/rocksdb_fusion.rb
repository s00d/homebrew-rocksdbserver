class RocksdbFusion < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.1.1"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v${version}/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "81b4f3f8f61e296ddc589276add27ebd9207839d5345eed50b9d60ca20e1a64f"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v${version}/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "81b4f3f8f61e296ddc589276add27ebd9207839d5345eed50b9d60ca20e1a64f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v${version}/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "81b4f3f8f61e296ddc589276add27ebd9207839d5345eed50b9d60ca20e1a64f"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v${version}/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "81b4f3f8f61e296ddc589276add27ebd9207839d5345eed50b9d60ca20e1a64f"
    end
  end

  def install
    bin.install "rocksdb_server"
  end

  service do
      run [opt_bin/"rocksdb_server"]
      keep_alive true
      working_dir var
      log_path var/"log/rocksdb_server.log"
      error_log_path var/"log/rocksdb_server.log"
    end

  test do
    system "#{bin}/rocksdb_server", "--version"
  end
end
