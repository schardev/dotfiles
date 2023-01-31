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
alias pp='pnpm'
alias px='pnpm dlx'
alias pe='pnpm exec'
alias quit='exit'
alias vim='nvim'
alias v='nvim'
# }}}

## Use modern replacements for common GNU programs
# {{{
if (( $+commands[exa] )); then
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
    alias update-mirrorlist='reflector --sort rate -f 30 -p https --download-timeout 3 -c India -c Singapore -c Sweden -c Bangladesh'
    alias open='xdg-open'

    # Repeat last command with sudo
    alias fuck='sudo $(fc -ln -1)'

    # NOTE: Remove once this gets fixed - https://github.com/neovim/neovim/issues/21699
    if (( $+commands[wezterm] )); then
        alias nvim='TERM=wezterm nvim'
        alias v='TERM=wezterm nvim'
        alias vim='TERM=wezterm nvim'
    fi
else
    alias open='termux-open'
fi
# }}}

# vim: fdm=marker
