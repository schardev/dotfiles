## Common aliases
# {{{
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ../'
alias c='clear'
alias diff='diff --color'
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias gti='git' # I quite often mistype `git` as `gti`
alias quit='exit'
alias vim='nvim'
alias v='nvim'
# }}}

## Use modern replacements for common GNU programs
# {{{
if (( $+commands[eza] )); then
    alias ls='eza'
    alias l='eza'
    alias la='eza -a'
    alias ll='eza -lh'
    alias lll='eza -lah'
    alias tree='eza --tree --git-ignore'
else
    alias l='ls --color=auto'
    alias la='ls --color=auto -a'
    alias ll='ls --color=auto -lh'
    alias lll='ls --color=auto -lah'
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh --cmd cd)"
else
    echo "zoxide is not installed. Using built-in 'cd'."
fi

if (( $+commands[bat] )); then
    alias cat="bat --plain"
fi
# }}}

## Workstation-only aliases
# {{{
if [[ -z $IS_TERMUX ]]; then
    alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
    alias clean-cache='paccache -rvk2 && paccache -ruk0'
    alias update-mirrorlist='sudo reflector --sort rate --latest 50 -p https --download-timeout 5 -c "India,Singapore,Sweden,Bangladesh, " --save /etc/pacman.d/mirrorlist'
    alias open='xdg-open'

    # Repeat last command with sudo
    alias fuck='sudo $(fc -ln -1)'
else
    alias open='termux-open'
fi
# }}}

# vim: fdm=marker
