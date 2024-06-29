# Homebrew Tap for RocksDBFusion

This repository contains the Homebrew formulas for installing RocksDBFusion Server, CLI client, and Viewer application.

## How to Use

First, you need to tap this repository:

```sh
brew tap s00d/rocksdbserver
```

Once the repository is tapped, you can install the desired components with the following commands:

### Install RocksDBFusion Server

```sh
brew install rocksdb_server
```

### Install RocksDBFusion CLI Client

```sh
brew install rocksdb_cli
```

### Install RocksDB Viewer Application

```sh
brew install --cask rocksdb-viewer
```

## Formula Details

### RocksDBFusion Server

- **Description**: RocksDB server is designed to handle database operations over TCP connections.
- **Homepage**: [RocksDBFusion Homepage](https://github.com/s00d/RocksDBFusion)

This formula installs the pre-built binaries of RocksDBFusion Server for macOS and Linux.

### RocksDBFusion CLI Client

- **Description**: RocksDB CLI client for interacting with a RocksDB server.
- **Homepage**: [RocksDBFusion Homepage](https://github.com/s00d/RocksDBFusion)

This formula installs the pre-built binaries of RocksDBFusion CLI Client for macOS and Linux.

### RocksDB Viewer Application

- **Description**: A GUI application to view and interact with a RocksDB database.
- **Homepage**: [RocksDBFusion Homepage](https://github.com/s00d/RocksDBFusion)

This cask installs the pre-built binaries of RocksDB Viewer for macOS.

## Updating the Formula

The formulas in this repository are updated automatically by a GitHub Actions workflow from the main RocksDBFusion repository. The workflow ensures that the formulas use the latest versions of RocksDBFusion components and the correct SHA256 checksums for the binaries.

## Contributing

If you find any issues with the formulas or have suggestions for improvements, feel free to open an issue or a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
