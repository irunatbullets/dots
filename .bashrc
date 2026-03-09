# Source system-wide bashrc if it exists
[[ -f /etc/bashrc ]] && source /etc/bashrc

# Basic PATH additions
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Determine Linuxbrew path
# - Host install: $HOME/.linuxbrew
# - Mounted Distrobox install: /home/linuxbrew/.linuxbrew
BREW_PATH="$HOME/.linuxbrew"
if [[ ! -x "$BREW_PATH/bin/brew" && -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    BREW_PATH="/home/linuxbrew/.linuxbrew"
fi

# Only load Linuxbrew and Starship if NOT Alpine
if [[ "$(cat /etc/os-release 2>/dev/null | grep -i '^ID=')" != "ID=alpine" ]]; then
    # Linuxbrew (Homebrew) integration
    if [[ -x "$BREW_PATH/bin/brew" ]]; then
        export PATH="$BREW_PATH/bin:$PATH"
        eval "$($BREW_PATH/bin/brew shellenv)"
    fi

    # Initialize Starship prompt (only if installed)
    if command -v starship >/dev/null 2>&1; then
        eval "$(starship init bash)"
    fi
fi

# Editor defaults
export EDITOR=vim
export VISUAL=vim

# Enable colors for default bash
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Distrobox tweaks
if [[ -n "$DISTROBOX_NAME" ]]; then
    alias open='distrobox-host-exec xdg-open'
fi

# Source additional user scripts
if [[ -d "$HOME/.bashrc.d" ]]; then
    for rc in "$HOME/.bashrc.d"/*; do
        [[ -f "$rc" ]] && source "$rc"
    done
fi


