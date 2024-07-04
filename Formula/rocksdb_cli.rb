class RocksdbCli < Formula
  desc "RocksDB CLI client for database operations"
  homepage "https://github.com/s00d/RocksDBFusion"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/rocksdb-cli-v0.1.2/rocksdb_cli-Darwin-x86_64.tar.gz"
      sha256 "2223d9aa1722b4dd6286b1ca561c4ac480358b2ed5ff583029f24732f16f86cf"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/rocksdb-cli-v0.1.2/rocksdb_cli-Darwin-aarch64.tar.gz"
      sha256 "895c23d073e962893ac09a703d34e98ae81c8e7a2eb6a24841ba95a3fa7c5967"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/s00d/RocksDBFusion/releases/download/rocksdb-cli-v0.1.2/rocksdb_cli-Linux-x86_64-musl.tar.gz"
      sha256 "612932f5aa48f65b7e8c1d8fe81bbb22d81d27c7b28dffa591afdedcaa4fe8c9"
    elsif Hardware::CPU.arm?
      url "https://github.com/s00d/RocksDBFusion/releases/download/rocksdb-cli-v0.1.2/rocksdb_cli-Linux-aarch64-musl.tar.gz"
      sha256 "31837df5b7f6b54ad626109460f0d2357a82182a4a6b5b26164fdfd665c79cb3"
    end
  end

  def install
    bin.install "rocksdb_cli"

    # Make the binary executable
    chmod "+x", "#{bin}/rocksdb_cli"

    # Clear extended attributes and sign the binary (macOS only)
    if OS.mac?
      ohai "During the installation process, you will be prompted to enter your password."
      ohai "This is necessary to make the binary executable and to self-sign the application"
      ohai "using the `xattr` and `codesign` commands to ensure it runs correctly on macOS."

      system "/usr/bin/xattr", "-cr", "#{bin}/rocksdb_cli"
      system "/usr/bin/codesign", "--force", "--deep", "--sign", "-", "#{bin}/rocksdb_cli"
    end
  end

  test do
    system "#{bin}/rocksdb_cli", "--version"
  end

end
