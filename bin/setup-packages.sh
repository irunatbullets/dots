#!/usr/bin/env bash
set -euo pipefail

# Point to the repo root (works from bin/)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_FILE="$DOTFILES_DIR/packages.txt"

install_pkg() {
    if dpkg -s "$1" >/dev/null 2>&1; then
        echo "✅ $1 already installed"
    else
        echo "📦 Installing $1"
        sudo apt install -y "$1"
    fi
}

echo "🔄 Updating apt index"
sudo apt update

# Read packages.txt line by line
while IFS= read -r pkg || [ -n "$pkg" ]; do
    # Skip empty lines or comments
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    install_pkg "$pkg"
done < "$PACKAGE_FILE"

echo "✅ Package setup complete"
