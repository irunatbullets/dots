#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check brew
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew is not installed."
  echo "👉 Install it first: https://brew.sh"
  exit 1
fi

# Install NVM via Homebrew if not installed
if ! brew list nvm >/dev/null 2>&1; then
    echo "🚀 Installing NVM"
    brew install nvm
    echo "✅ NVM installed"
else
    echo "✅ NVM already installed"
fi

# Ensure ~/.nvm exists
mkdir -p "$HOME/.nvm"
echo "✅ ~/.nvm directory exists"

# Ensure ~/.bashrc.d exists
mkdir -p "$HOME/.bashrc.d"

# Write NVM setup script in dotfiles directory if it doesn't exist
mkdir -p "$DOTFILES_DIR/.bashrc.d"
NVM_SCRIPT="$DOTFILES_DIR/.bashrc.d/nvm.sh"

cat > "$NVM_SCRIPT" <<'EOF'
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF

echo "✅ NVM setup script created in $NVM_SCRIPT"

# Symlink the NVM script into ~/.bashrc.d
ln -sf "$NVM_SCRIPT" "$HOME/.bashrc.d/$(basename "$NVM_SCRIPT")"
echo "✅ NVM script symlinked to ~/.bashrc.d"

echo
echo "🧾 Note: Restart your terminal or run 'source ~/.bashrc' to start using NVM."


