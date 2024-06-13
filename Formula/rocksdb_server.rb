class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.1.1"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.1/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "06258d57a8a5ce9d322184ffb3e3040ee6cefdd0f485cc69028e42875d467633"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.1/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "febe273d0bca518e07580e8436231c6da9f566d71c38b5daa9cbb8ad7da0945c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.1/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "b020cc0ac6d2923fac6de6722c8bb892b0ca97c77c12c5493c2479b849d88646"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.1/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "81b4f3f8f61e296ddc589276add27ebd9207839d5345eed50b9d60ca20e1a64f"
    end
  end

  def install
    bin.install "rocksdb_server"
  end

  service do
      environment_variables ROCKSDB_PATH: "#{var}/rocksdb/db", ROCKSDB_PORT: "12345", ROCKSDB_LOCK_FILE: "#{var}/rocksdb/rocksdb.lock"

      run [
        opt_bin/"rocksdb_server",
        "--dbpath", "${PATH_TO_DB}",
        "--port", "${PORT}",
        "--lock-file", "${LOCK_FILE}",
        "--host", "127.0.0.1",
        "--log-level", "info"
      ]
      keep_alive true
      working_dir var
      log_path var/"log/rocksdb_server.log"
      error_log_path var/"log/rocksdb_server.log"
    end

  test do
    system "#{bin}/rocksdb_server", "--version"
  end
end
