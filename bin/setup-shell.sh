#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew is not installed."
  echo "👉 Install it first: https://brew.sh"
  exit 1
fi

if ! brew list starship >/dev/null 2>&1; then
    echo "🚀 Installing starship"
    brew install starship
    echo "✅ Starship installed"
else
    echo "✅ Starship already installed"
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Symlink Starship config
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
echo "✅ Starship config installed"

# Backup existing .bashrc if it's a regular file (not a symlink)
if [[ -f "$HOME/.bashrc" && ! -L "$HOME/.bashrc" ]]; then
    echo "Backing up existing ~/.bashrc to ~/.bashrc.backup"
    mv "$HOME/.bashrc" "$HOME/.bashrc.backup"
fi

# Symlink main .bashrc from dotfiles
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
echo "✅ .bashrc installed"

# Ensure ~/.bashrc.d exists
mkdir -p "$HOME/.bashrc.d"

# Symlink all scripts in dotfiles/.bashrc.d to ~/.bashrc.d
if [[ -d "$DOTFILES_DIR/.bashrc.d" ]]; then
    shopt -s nullglob
    for script in "$DOTFILES_DIR/.bashrc.d"/*; do
        ln -sf "$script" "$HOME/.bashrc.d/$(basename "$script")"
        echo "✅ $(basename "$script") installed in ~/.bashrc.d"
    done
    shopt -u nullglob
fi

cat <<'EOF'

🧾 Note:
If you use distrobox, recreate containers with
/home/linuxbrew/.linuxbrew mounted as a volume.

EOF
