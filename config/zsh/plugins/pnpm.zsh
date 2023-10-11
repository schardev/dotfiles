if ! (( $+commands[pnpm] )); then
    return
fi

alias pe='pnpm exec'
alias pi="pnpm add"
alias pp='pnpm'
alias px='pnpm dlx'
alias update-pnpm="corepack prepare pnpm@latest --activate"

# Source completion file if exists
completion_file="$XDG_CONFIG_HOME"/tabtab/zsh/pnpm.zsh
[[ -f "$completion_file" ]] && source "$completion_file"
unset completion_file # avoid polluting global env
