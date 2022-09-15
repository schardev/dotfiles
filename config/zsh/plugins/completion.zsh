# Few of the settings have been taken from this amazing zsh completion guide
# https://thevaluable.dev/zsh-completion-guide-examples/

# zstyle pattern syntax (zstyle <pattern> <style> <values>)
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Options
setopt auto_cd

# Remove '/' from wordchars
WORDCHARS=${WORDCHARS:s:/:}

# Completion menu
zstyle ':completion:*' menu select

# Source LS_COLORS and use them for tab completions
eval "$(dircolors)"
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}”

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME}/.zcompcache"

# Autocomplete . and .. special dirs
zstyle ':completion:*' special-dirs true

# Try normal completion and if nothing matches do a case-insensitive search
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Categorize and show descriptions of completion items
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{yellow}-- %d --%f'

# Show error if no match found
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
