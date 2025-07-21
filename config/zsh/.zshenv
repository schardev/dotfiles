# Use XDG base directory structure
export ZDOTDIR=$HOME/.config/zsh

# Set lang
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

case "$OSTYPE" in
    darwin*) export IS_MAC=true ;;
    linux-android) export IS_TERMUX=true ;;
    linux*) export IS_LINUX=true ;;
    msys* | cygwin*) export IS_WINDOWS=true ;;
    *) echo "unknown: $OSTYPE" ;;
esac

# Non-termux env vars
if [[ -z $IS_TERMUX ]]; then
    export MANPAGER="nvim +Man!" # Use `neovim` as manpager for colored man pages
fi

# xdg base directories (https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories)
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export CONFIG_DIR="$HOME/dotfiles/config"
export DOTS_DIR="$HOME/dotfiles"
export SHELDON_CONFIG_DIR=$XDG_CONFIG_HOME/zsh # https://github.com/rossmacarthur/sheldon
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/zsh/starship.toml"
export EDITOR=nvim
export VISUAL=nvim
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# Export GPG_TTY using $TTY (works even when stdin is redirected)
export GPG_TTY=$TTY

# PATH
# (N-/): do not register if the directory does not exists (credit @akinsho)
path=(
    "$PNPM_HOME" # Prepending pnpm bin directory to pick up specific node versions from there
    "${path[@]}"
    "$CONFIG_DIR"/bin(N-/)
    "$XDG_DATA_HOME"/npm-global/bin(N-/)
    "$HOME"/.local/bin(N-/)
)

# remove duplicate entries from $PATH
typeset -U PATH path

# Load local overrides if present
if [[ -f "$HOME/.env.local" ]]; then
    source "$HOME/.env.local"
fi
