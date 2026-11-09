#!/usr/bin/env bash
set -euo pipefail

REPO="anna-ssg/anna"
ARCH="Linux_x86_64"

# 1. Fetch only stable production versions, ignoring prereleases (-rc, -beta, etc.)
echo "Fetching latest stable release info for $REPO..."
LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases" | \
  grep -m 1 '"tag_name":' | \
  sed -E 's/.*"tag_name":[[:space:]]*"([^"]+)".*/\1/')

# Fallback version check or explicit override via environment variable
VERSION="${ANNA_VERSION:-$LATEST_TAG}"

if [[ -z "$VERSION" ]]; then
  echo "Error: Failed to determine stable release tag automatically."
  exit 1
fi

echo "Selected Release Version: $VERSION"
TARBALL="anna_${ARCH}.tar.gz"
URL="https://github.com"

# 2. Download and extract safely
echo "Downloading $URL..."
if ! curl -sSLf -L "$URL" | tar -xz; then
  echo "Error: Failed to download or extract the binary from $URL"
  exit 1
fi

if [[ ! -f anna ]]; then
  echo "Error: 'anna' binary not found after extraction"
  exit 1
fi

# 3. Make executable and run build
chmod +x anna 
echo "Running anna build engine..."
./anna
