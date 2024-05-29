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
