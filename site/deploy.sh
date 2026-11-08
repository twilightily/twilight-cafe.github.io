#!/usr/bin/env bash
set -euo pipefail
REPO="anna-ssg/anna"
ARCH="Linux_x86_64"

# 1. Hardcode the stable tag name instead of fetching the broken v5 pre-release
LATEST_TAG="v0.4.0" 

echo "Using locked stable release: $LATEST_TAG"
TARBALL="anna_${ARCH}.tar.gz"
URL="https://github.com/$REPO/releases/download/$LATEST_TAG/$TARBALL"

echo "Downloading $URL..."
curl -L "$URL" | tar -xz

if [[ ! -f anna ]]; then
  echo "anna binary not found after extraction"
  exit 1
fi

chmod +x anna && echo "Running anna..."
./anna
