#!/usr/bin/env bash
set -euo pipefail

if command -v bw >/dev/null 2>&1; then
  echo "bw già installato: $(command -v bw)"
  bw --version
  exit 0
fi

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y wget unzip ca-certificates
else
  echo "Errore: apt-get non disponibile. Installa manualmente wget, unzip e ca-certificates."
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

wget "https://vault.bitwarden.com/download/?app=cli&platform=linux" -O "$tmpdir/bw.zip"
unzip -o "$tmpdir/bw.zip" -d "$tmpdir"
chmod +x "$tmpdir/bw"
sudo mv "$tmpdir/bw" /usr/local/bin/bw

echo "Installazione completata."
command -v bw
bw --version
