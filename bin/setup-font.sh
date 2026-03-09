#!/usr/bin/env bash
set -euo pipefail

FONT_CASK="font-dejavu-sans-mono-nerd-font"
FONT_DISPLAY_NAME="DejaVuSansM Nerd Font Mono"

# Check brew
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew is not installed."
  echo "👉 Install it first: https://brew.sh"
  exit 1
fi

# Install font
echo "📦 Installing $FONT_CASK..."
brew install --cask "$FONT_CASK"

echo "✅ Font installed"

# Refresh font cache (safe no-op on some systems)
if command -v fc-cache >/dev/null 2>&1; then
  echo "🔄 Refreshing font cache..."
  fc-cache -f
fi

cat <<EOF

🧾 Manual font setup

Terminal foot:
font=DejaVuSansM Nerd Font Mono:size=11

Terminal (Ptyxis / GNOME Terminal):
Appearance → Font → "$FONT_DISPLAY_NAME"

VSCodium:
vscodium://settings/editor.fontFamily
'$FONT_DISPLAY_NAME', monospace

If you have UI font issues with VSCodium installed via brew:
mkdir -p ~/.fonts
wget -O ~/.fonts/NotoSans-Regular.ttf https://github.com/google/fonts/raw/main/ofl/notosans/NotoSans%5Bwdth%2Cwght%5D.ttf
fc-cache -fv


EOF

