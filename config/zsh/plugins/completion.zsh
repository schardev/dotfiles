# Completion settings
WORDCHARS=${WORDCHARS:s:/:} # Remove '/' from wordchars
zstyle ':completion:*:*:*:*:*' menu select
eval "$(dircolors)" # Source LS_COLORS and use them for tab completions
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}”
zstyle ':completion:*' use-cache yes # Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' special-dirs true # Autocomplete . and .. special dirs
