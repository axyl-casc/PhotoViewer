#!/usr/bin/env bash

# Install and run PhotoPrism from source without Docker.
# Works on Ubuntu/Debian or Arch systems.

set -e

# Location of photo originals
PHOTOS_PATH="${PHOTOS_PATH:-$HOME/Pictures}"

# Install dependencies using apt (Debian/Ubuntu) or pacman (Arch)
if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y git golang-go nodejs npm mariadb-server ffmpeg
    if ! command -v yarn >/dev/null 2>&1; then
        sudo npm install -g yarn
    fi
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --needed git go nodejs npm mariadb ffmpeg yarn
else
    echo "Unsupported package manager. Install Go, Node.js, Yarn, and MariaDB manually." >&2
    exit 1
fi

if [ ! -d photoprism ]; then
    git clone https://github.com/photoprism/photoprism.git
fi
cd photoprism

cp -n .env.example .env
sed -i "s|PHOTOPRISM_ORIGINALS_PATH=.*|PHOTOPRISM_ORIGINALS_PATH=\"$PHOTOS_PATH\"|" .env
sed -i "s|PHOTOPRISM_ADMIN_PASSWORD=.*|PHOTOPRISM_ADMIN_PASSWORD=\"insecure\"|" .env
sed -i "s|PHOTOPRISM_HTTP_PORT=.*|PHOTOPRISM_HTTP_PORT=2342|" .env

# Build frontend
yarn install
yarn build

# Run PhotoPrism

go run ./cmd/photoprism start
# After the server starts, index photos with:
#   ./photoprism index
