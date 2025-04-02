# Initialize homebrew
if [[ -n $IS_MAC ]]; then
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "brew is not installed!" >&2
    fi
fi

# Initialize starship prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
else
    echo "starship is not installed!" >&2
fi

# Initialize sheldon if installed
# https://github.com/rossmacarthur/sheldon
if (( $+commands[sheldon] )); then
    eval "$(sheldon source)"
else
    echo "sheldon is not installed!" >&2
fi

# Source local plugins
for plugin in "$XDG_CONFIG_HOME"/zsh/plugins/*; do
    source "$plugin"
done
