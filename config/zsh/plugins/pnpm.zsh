if ! (( $+commands[pnpm] )); then
    return
fi

# Source completion file if exists
completion_file="$XDG_CONFIG_HOME"/tabtab/zsh/pnpm.zsh
[[ -f "$completion_file" ]] && source "$completion_file"
unset completion_file # avoid polluting global env
