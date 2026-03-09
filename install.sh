#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting dotfiles installation"

if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew is not installed."
  echo "👉 Install it first: https://brew.sh"
  exit 1
fi

./bin/setup-packages.sh
./bin/setup-shell.sh
./bin/setup-git.sh
./bin/setup-nvm.sh
./bin/setup-font.sh
./bin/setup-vim.sh
./bin/setup-desktop.sh

echo
echo "✅ Dotfiles installation complete"
