# History
HISTFILE=${XDG_CACHE_HOME:-$HOME}/.zsh_history
HISTSIZE=5000                   # History loaded into memory
SAVEHIST=$HISTSIZE              # Max commands to save in $HISTFILE
setopt share_history            # Share history across terminals
setopt inc_append_history       # Immediately append to the history file, not just when a term is killed
setopt hist_expire_dups_first   # Trim duplicate entries first
setopt hist_find_no_dups        # Don't show repeated commands
setopt hist_ignore_all_dups     # Removes older entry if it dublicates the current
setopt hist_ignore_dups         # Ignore current command if previously entered

# Change highlighting for matched strings (need `zsh-history-substring-search` plugin)
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=black,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=black,bold"
