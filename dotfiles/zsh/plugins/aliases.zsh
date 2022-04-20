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
alias ls='ls --color=auto'
alias quit='exit'
alias vim='nvim'

if [ -n "$IS_TERMUX" ]; then
    # Termux-only aliases
    alias l='ls --color=auto'
    alias la='ls --color=auto -a'
    alias ll='ls --color=auto -lh'
    alias lll='ls --color=auto -lah'
else
    # Workstation-only aliases
    alias clean-cache='paccache -rvk2 && paccache -ruk0'
    alias l='exa'
    alias la='exa -a'
    alias ll='exa -lh'
    alias lll='exa -lah'
    alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
fi

# vim: set filetype=sh: