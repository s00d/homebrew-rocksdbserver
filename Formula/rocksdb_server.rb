class RocksdbServer < Formula
  desc "RocksDB server is designed to handle database operations over TCP connections"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.1.2"  # Эта версия будет заменена через GitHub Actions

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.2/rocksdb_server-Darwin-x86_64.tar.gz"
      sha256 "d606b9f1f80eaebd41cc6e6495e636bf700d9205bee87fe412b5da49748a0417"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.2/rocksdb_server-Darwin-aarch64.tar.gz"
      sha256 "5171571c3a395fe7107fca3b2a93ff773b62e8a68eb622d3479f57e5c6a38610"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.2/rocksdb_server-Linux-x86_64-musl.tar.gz"
      sha256 "8e71bc9282dea100ede827d42e581e3f5d2f0bd31e2d0bfa8662fb6e0990b002"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/server-v0.1.2/rocksdb_server-Linux-aarch64-musl.tar.gz"
      sha256 "724e0ddafc241ba48261708fb4efee7ed36db8e9f92f2eb756a355cf872efaa5"
    end
  end

  def install
      bin.install "rocksdb_server"
      (bin/"rocksdb_server_wrapper").write <<~EOS
        #!/bin/bash
        export ROCKSDB_PATH=${ROCKSDB_PATH:-#{var}/rocksdb/db}
        export ROCKSDB_PORT=${ROCKSDB_PORT:-12345}
        export ROCKSDB_LOCK_FILE=${ROCKSDB_LOCK_FILE:-#{var}/rocksdb/rocksdb.lock}

        mkdir -p $(dirname $ROCKSDB_PATH)

        exec #{opt_bin}/rocksdb_server --dbpath $ROCKSDB_PATH --port $ROCKSDB_PORT --lock-file $ROCKSDB_LOCK_FILE --host 127.0.0.1 --log-level info
      EOS
      chmod 0755, bin/"rocksdb_server_wrapper"
    end

    service do
      run [opt_bin/"rocksdb_server_wrapper"]
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
