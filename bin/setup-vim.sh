#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔧 Installing vim-plug"

if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "✅ vim-plug installed"
else
    echo "✅ vim-plug already installed"
fi

echo "🔗 Linking .vimrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

echo "📦 Installing Vim plugins"
vim +PlugInstall +qall

echo "✅ Vim setup complete"
