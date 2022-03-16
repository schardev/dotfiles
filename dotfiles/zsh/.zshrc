# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Shout out loud if running on termux
if [[ $PREFIX =~ com.termux ]]; then
    export IS_TERMUX=1 # exporting value to `1` instead of `true` because vim
                       # does't treat "every" string as truthy
fi

# Initialize sheldon
eval "$(sheldon source)"

# Configure plugins
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5C' forward-word
setxkbmap -option "caps:escape"

# Completion settings
WORDCHARS=${WORDCHARS:s:/:}                             # Remove '/' from wordchars

zstyle ':completion:*:*:*:*:*' menu select
eval "$(dircolors)"                                     # Source LS_COLORS and use them for
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}” # tab completions
zstyle ':completion:*' use-cache yes                    # Use caching so that commands like
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR        # apt and dpkg complete are useable
zstyle ':completion:*' special-dirs true                # Autocomplete . and .. special dirs

# Initialize completion stuff
autoload -Uz compinit && compinit

# Export GPG_TTY using $TTY (works even when stdin is redirected)
export GPG_TTY=$TTY

# Source common script
source "${HOME}"/env/funcs/common-funcs.sh

# Start `ssh-agent` if not already and add keys (env/common)
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" >/dev/null
    pgrep -g "${SSH_AGENT_PID}" >/dev/null || {
        start_agent
    }
else
    start_agent
fi

# Set bat as man pager (except for termux since it needs a wrapper for that)
if [ -z "$IS_TERMUX" ]; then
    # Use `bat` as manpager for colored man pages
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Set global editor to neovim
export EDITOR=nvim

#To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
