# Shout out loud if running on termux
if [[ $PREFIX =~ com.termux ]]; then
    export IS_TERMUX=true
fi

# Non-termux env vars
if [ -z "$IS_TERMUX" ]; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Use `bat` as manpager for colored man pages
fi

export CONFIG_DIR="${0:A:h:h:h:h}" # Export location of dotfiles' directory
export EDITOR=nvim # Set global editor to neovim
export GPG_TTY=$TTY # Export GPG_TTY using $TTY (works even when stdin is redirected)
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND # Disable highlighting for matched strings
