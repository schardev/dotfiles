# Initialize starship prompt
eval "$(starship init zsh)"

# Initialize sheldon if installed
# https://github.com/rossmacarthur/sheldon
if (( $+commands[sheldon] )); then
    eval "$(sheldon source)"
else
    echo "sheldon is not installed!" >&2
fi

# Add local function definitions to fpath and autoload them when called
fpath=("$HOME/.config/zsh/functions" "${fpath[@]}")
for i in "$HOME"/.config/zsh/functions/*(:t); do
    autoload -Uz $i
done

# Source local plugins
for plugin in "$HOME"/.config/zsh/plugins/*; do
    source "$plugin"
done
