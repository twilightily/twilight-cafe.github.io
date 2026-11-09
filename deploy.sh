#!/usr/bin/env bash
set -euo pipefail

# Breaking the URL into tiny pieces so it does not get cut off by the text box
HOST="https://github.com"
PATH="/anna-ssg/anna/releases/download"
FILE="/v4.0.0/anna_Linux_x86_64.tar.gz"

FULL_URL="${HOST}${PATH}${FILE}"

echo "Downloading Anna v4.0.0..."
if ! curl -sSLf -L "$FULL_URL" | tar -xz; then
  echo "Error: Failed to download or extract the binary"
  exit 1
fi

if [[ ! -f anna ]]; then
  echo "Error: 'anna' binary not found after extraction"
  exit 1
fi

chmod +x anna 
echo "Running anna build engine..."
./anna
