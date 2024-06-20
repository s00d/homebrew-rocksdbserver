class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.2.4"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.4/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "42db8c162a2e261685adbe72bef1a05436e24c7169c468e9023fc72ea3fc64b8"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.4/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "78bfc38402d167a14ea12816eecdf5d7f122bea1a982406de691736d7e031485"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.4/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "8052a6411dcc8c57971c3b891e7a5dc5ba320df8f65d7b6815153ec722163f8c"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.2.4/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "ee40333d3e7325319343ea844de6d0b29bca173c033c9593c8da7e878d1bc5ba"
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
