# Use XDG base directory structure
export ZDOTDIR=$HOME/.config/zsh

# Shout out loud if running on termux
if [[ $PREFIX =~ com.termux ]]; then
    export IS_TERMUX=true
else
    # Non-termux env vars
    export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Use `bat` as manpager for colored man pages
fi

# xdg base directories (https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories)
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export CONFIG_DIR="$HOME/dotfiles" # Export location of dotfiles' directory
export EDITOR=nvim # Set global editor to neovim
export GPG_TTY=$TTY # Export GPG_TTY using $TTY (works even when stdin is redirected)
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND # Disable highlighting for matched strings

# PATH
path+=(
    "$CONFIG_DIR"/bin
    "$HOME"/.npm-global/bin
)
export PATH
