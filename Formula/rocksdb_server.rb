class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.2.3"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.3/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "c4fb0372df040d7e0d554bad9772f258cacd295ae34255e70bedecbad65f30f1"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.3/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "a6cabf1d7ae784014a74c491f8c81cfafd72d61b1c433128e60c5aa248087ef0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.3/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "1416a9a721a9acf30b3f2f54c96ccaecc1c7dcd632a2b64d1ff1d6e5d49dc2fa"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.3/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "3008fa03a043c384f3a800940f5982b3d16c7bc5632839b55a35d2e0ce1b0779"
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
