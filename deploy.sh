#!/usr/bin/env bash
set -euo pipefail
REPO="anna-ssg/anna"
ARCH="Linux_x86_64"

LATEST_TAG="v0.4.0" 

echo "Using locked stable release: $LATEST_TAG"
TARBALL="anna_${ARCH}.tar.gz"
URL="https://github.com"

echo "Downloading $URL..."
curl -L "$URL" | tar -xz

if [[ ! -f anna ]]; then
  echo "anna binary not found after extraction"
  exit 1
fi

chmod +x anna && echo "Running anna..."
./anna
