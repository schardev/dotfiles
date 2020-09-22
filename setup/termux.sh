#!/data/data/com.termux/files/usr/bin/bash
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2020 Saurabh Charde <saurabhchardereal@gmail.com>
#

SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
TERMUX_STYLE="$SCRIPT_PATH/../modules/termux-style"

# packages to install
pkg install -y \
    git \
    nano \
    vim \
    openssh \
    gnupg \
    binutils \
    wget

# add custom buttons layout and theme
mkdir ~/.termux && touch ~/.termux/termux.properties
echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" > ~/.termux/termux.properties
[[ -d "$TERMUX_STYLE" ]] && setupTheme

# parse git branch to show in prompt style
# kanged from https://github.com/krasCGQ/scripts
parseGitBranch() {
        local BRANCH
        BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/^* //')

        if [[ -n $BRANCH ]]; then
            # Don't give extra brackets if project isn't at any branch or is currently detached
            [[ $BRANCH != "("*")" ]] && BRANCH="($BRANCH)"

            # This is what we want to stdout
            echo " $BRANCH"
        fi
}

# settings I use for moi setup
cat >> "$HOME"/.bashrc <<'EOF'

# vim FTW
export EDITOR=vim

# for gpg signature
export GPG_TTY=$(tty)

# aliases
alias l='ls'
alias ll='ls -l'
alias la='ls -al'

# override default prompt style
export PS1='\[\e[1;36m\]\w\[\e[1;34m\]$(parseGitBranch) ❯\[\e[0m\] '
EOF

setupTheme() {
    # use Dracula color scheme & Hack font by default
    # can be changed after installing termux-style anyway
    cp "$TERMUX_STYLE"/colors/dracula.properties "$HOME"/.termux/colors.properties
    cp "$TERMUX_STYLE"/fonts/Hack.ttf "$HOME"/.termux/font.ttf
}
