# Shout out loud if running on termux
if [[ $PREFIX =~ com.termux ]]; then
    export IS_TERMUX=true
fi

# Set bat as man pager (except for termux since it needs a wrapper for that)
if [ -z "$IS_TERMUX" ]; then
    # Use `bat` as manpager for colored man pages
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"

    # Use caps lock as escape key
    setxkbmap -option "caps:escape"
fi

export EDITOR=nvim # Set global editor to neovim
export GPG_TTY=$TTY # Export GPG_TTY using $TTY (works even when stdin is redirected)
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND # Disable highlighting for matched strings
