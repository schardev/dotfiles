# Setup fzf keybindings if installed
if ! (( $+commands[fzf] )); then
    return
fi

# NOTE: Everything below will be available globally, make sure you don't shadow
# already existing builtins/commands

# `${PREFIX}` will be set in termux env
source "${PREFIX:-/usr}"/share/fzf/key-bindings.zsh

# Use fd as primary indexer globally
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --follow"
export FZF_DEFAULT_OPTS="--bind 'alt-w:toggle-preview-wrap'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--height 100% --preview 'exa --tree {}'"
# alias fh='(cd $HOME; fv)'
# alias fd='(cd $DOTS_DIR; fv)'

## Few useful utilities

# Search file using fzf and opens it in vim if present
function fv() {
    # Enable preview if not in termux
    local opts
    [[ -z "$IS_TERMUX" ]] &&
        opts="--multi --preview 'bat --style=numbers --color=always --line-range :250 {}'"

    # Invoke fzf and select files
    local files=()
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $opts" fzf | while IFS= read -r file; do files+=("$file"); done

    [[ -n "${files[1]}" ]] && vim ${files[@]}
}

# Search file using fzf and opens using `xdg-open` or similar command
function fopen() {
    # Invoke fzf and select files
    local files=()
    fzf --multi | while IFS= read -r file; do files+=("$file"); done

    # `open` is an alias to relevant command in different setups
    # e.g. `termux-open` in termux and `xdg-open` in linux, echos file if no alias is set
    if (( $+aliases[open] )); then
        [[ -n "${files[1]}" ]] && open ${files[@]}
    else
        echo "${files[@]}"
    fi
}

# ripgrep <3 fzf
# https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-the-secondary-filter
function fr() {
    local rg_opts=(--color=always --line-number --no-heading --smart-case)

    while ((${#})); do
        case "${1}" in
            -h)
                rg_opts+=(--hidden)
                shift
                ;;
            -f)
                local force=true
                shift
                ;;
            *)
                # if a search string is provided then break processing args
                break
                ;;
        esac
    done

    # Avoid running from $HOME
    if [[ "$PWD" == "$HOME" && "$force" != "true" ]]; then
        echo "Running from '\$HOME' is slow! Use '${0} -f' to force." && return
    fi

    # 1. Search for text in files using Ripgrep
    # 2. Interactively narrow down the list using fzf
    # 3. Open the file in Vim
    local files=()

    rg "${rg_opts[@]}" "${*:-}" | \
        fzf --multi --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' | \
        while IFS= read -r file; do files+=("${file%%:*}"); done

    [[ -n "${files[1]}" ]] && vim ${files[@]}
}
