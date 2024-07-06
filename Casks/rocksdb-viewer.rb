cask "rocksdb-viewer" do
  version "0.1.1"

  on_intel do
    sha256 "a9e4591c31560edbf58aae564a2e7f6a06d9ccb10521fa36f19f545bff495813"
    url "https://github.com/s00d/RocksDBFusion/releases/download/app-v0.1.1/rocksdb-viewer_0.1.1_x64.dmg"
  end

  on_arm do
    sha256 "e832d0d2a520ed9e2e47d0dfccab56612ab97f767ab0d850f9bfd1a9879057cc"
    url "https://github.com/s00d/RocksDBFusion/releases/download/app-v0.1.1/rocksdb-viewer_0.1.1_aarch64.dmg"
  end

  name "RocksDB Viewer"
  desc "A simple Tauri application to view and interact with a RocksDB database"
  homepage "https://github.com/s00d/RocksDBFusion"

  app "rocksdb-viewer.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{staged_path}/rocksdb-viewer.app"],
                   sudo: true

    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{staged_path}/rocksdb-viewer.app"],
                   sudo: true
  end

  zap trash: [
    "~/Library/Preferences/com.rocksdb.viewer.plist",
    "~/Library/Saved Application State/com.rocksdb.viewer.savedState",
  ]

  caveats <<~EOS
    During the installation process, you will be prompted to enter your password.
    This is necessary to clear extended attributes and to self-sign the application
    using the `xattr` and `codesign` commands to ensure it runs correctly on macOS.
  EOS
end
