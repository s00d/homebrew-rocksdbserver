cask "rocksdb-viewer" do
  version "0.0.3"

  on_intel do
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    url "https://github.com/s00d/RocksDBFusion/releases/download/app-v0.0.3/rocksdb-viewer_0.0.3_x64.dmg"
  end

  on_arm do
    sha256 "48e838ee87716d476328c8f1030662329ae2720756487cb11c5fcc81c48b0d57"
    url "https://github.com/s00d/RocksDBFusion/releases/download/app-v0.0.3/rocksdb-viewer_0.0.3_aarch64.dmg"
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
