class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.2.2"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.2/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "2f66a6082fe77f2e12f96579aa75a9ebeb56dfb9b3de0c27965636d629f1d6db"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.2/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "370d092ad0c088ec52183b2a386d5089f7133387c06a65fd9da451687afc4c53"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.2/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "4384bcf0765a930d2099768ddf1b909db09b53e1dfa2290fd9d4926c47498217"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.2/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "640d68dd855abb07b1481e866b4af3104626422e8b569d12d7bd77b5c93c24cd"
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
