bindkey -v # Use Vi mode
bindkey '^[[A' history-substring-search-up # Up arrow
bindkey '^[[B' history-substring-search-down # Down arrow
bindkey '^[[H' beginning-of-line # Home key
bindkey '^[[F' end-of-line # End key
bindkey '^[[1;5C' forward-word # Ctrl + Right arrow
bindkey '^[[1;5D' backward-word # Ctrl + Left arrow

if [ -z "$IS_TERMUX" ]; then
    setxkbmap -option "caps:escape" # Use caps lock as escape key
fi
