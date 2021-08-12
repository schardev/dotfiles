# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialize antibody and install plugins
eval "$(antibody init)"

PLUGINS=(
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    zsh-users/zsh-history-substring-search
    zdharma/fast-syntax-highlighting
    romkatv/powerlevel10k
)

for PLUGIN in "${PLUGINS[@]}"; do
    antibody bundle "${PLUGIN}"
done
unset PLUGINS

# Configure plugins
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line


# Completion settings
zstyle ':completion:*:*:*:*:*' menu select

eval "$(dircolors)"                                     # Source LS_COLORS and use them for
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}” # tab completions

zstyle ':completion:*' use-cache yes                    # Use caching so that commands like
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR        # apt and dpkg complete are useable

zstyle ':completion:*' special-dirs true                # Autocomplete . and .. special dirs

# Initialize completion stuff
autoload -U compinit && compinit

# Aliases
source ${ZDOTDIR:-$HOME}/.aliases

# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000                   # History loaded into memory
SAVEHIST=2000                   # Max commands to save in $HISTFILE
setopt share_history            # Share history across terminals
setopt inc_append_history       # Immediately append to the history file, not just when a term is killed
setopt hist_expire_dups_first   # Trim duplicate entries first
setopt hist_find_no_dups        # Don't show repeated commands
setopt hist_ignore_all_dups     # Removes older entry if it dublicates the current
setopt hist_ignore_dups         # Ignore current command if previously entered

# Export GPG_TTY using $TTY (works even when stdin is redirected)
export GPG_TTY=$TTY

# Source common script
source ${HOME}/scripts/common

#To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
