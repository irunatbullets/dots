#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.config"

link () {
    src="$DOTFILES_DIR/$1"
    dst="$HOME/$1"

    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"

    echo "🔗 Linked $1"
}

link ".config/foot"
link ".config/fuzzel"
link ".config/sway"
link ".config/starship.toml"

echo "✅ Desktop config installed"
