class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.1.7"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.7/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "37334c465b44ddca8e9c41a69c47afab7899e355e23320bfdf07e0d4f797f8be"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.7/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "7c3e4002f466f9451c6258dd0e9dbd08264fd3e72106516990c0f1357e020fdb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.7/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "88bf37a28d7f076f89c4e39dca2412689597e5be3200570e36afd9afcbeca0a7"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.7/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "5c1fbad1d946d839556077b9e09543cf0d279eab5b95c1a5ec3217aa4c8d1f0b"
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
      run_type :immediate
    end

  test do
    system "#{bin}/rocksdb_server", "--version"
  end
end
