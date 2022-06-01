# Common aliases
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ../'
alias c='clear'
alias diff='diff --color'
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias quit='exit'
alias vim='nvim'

if command -v exa >/dev/null; then
    alias ls='exa'
    alias l='exa'
    alias la='exa -a'
    alias ll='exa -lh'
    alias lll='exa -lah'
else
    alias l='ls --color=auto'
    alias la='ls --color=auto -a'
    alias ll='ls --color=auto -lh'
    alias lll='ls --color=auto -lah'
fi

# Workstation-only aliases
if [[ -z $IS_TERMUX ]]; then
    alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
    alias clean-cache='paccache -rvk2 && paccache -ruk0'
fi
