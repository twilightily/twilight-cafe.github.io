#!/usr/bin/env bash
set -euo pipefail

REPO="anna-ssg/anna"
ARCH="Linux_x86_64"

# Hardcode the working version to bypass GitHub's pre-release bug
VERSION="v4.0.0"

echo "Selected Stable Release Version: $VERSION"
TARBALL="anna_${ARCH}.tar.gz"
URL="https://github.com\$REPO/releases/download/\$VERSION/\$TARBALL"


# Download and extract safely
echo "Downloading $URL..."
if ! curl -sSLf -L "$URL" | tar -xz; then
  echo "Error: Failed to download or extract the binary from $URL"
  exit 1
fi

if [[ ! -f anna ]]; then
  echo "Error: 'anna' binary not found after extraction"
  exit 1
fi

# Make executable and run build
chmod +x anna 
echo "Running anna build engine..."
./anna
