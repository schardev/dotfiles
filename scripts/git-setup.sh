#!/bin/bash
#
# SPDX-License-Identifier: MIT
#
# Copyright (C) 2017-2020 Nathan Chancellor
# Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>
#
# git functions

# Check if my GPG key can be used
gpg_key_usable() {
    command -v gpg &>/dev/null || return 1
    gpg --list-secret-keys --keyid-format LONG | grep -q 5B8A4DC9B94B1C64599A961F5CACE763EF81E4D1
}

# Main gpg setup
gpg_setup() {
    if ! gpg_key_usable; then
        # clone keys repo and import (if not already)
        if ! [ -d "${HOME}/.keys" ]; then
            trap 'rm -rf ${HOME}/.keys' EXIT
            git clone https://github.com/schardev/keys "${HOME}"/.keys
            gpg --import "${HOME}"/.keys/{private,public}-key.gpg
        fi

        # shellcheck disable=SC2016
        [[ -n $BASH ]] && printf 'export GPG_TTY=$(tty)\n' >>"${HOME}"/.bashrc

        # cache gpg credential
        printf 'default-cache-ttl 604800\nmax-cache-ttl 2419200\n' >"${HOME}"/.gnupg/gpg-agent.conf

        # enable signing commits
        git config --global commit.gpgsign true
        git config --global user.signkey 5B8A4DC9B94B1C64599A961F5CACE763EF81E4D1
    fi
}

# Set git aliases
git_aliases() { (
    gpg_key_usable && GPG_SIGN="--gpg-sign"
    # SIGNOFF="--signoff"

    git config --global alias.aa 'add --all'
    git config --global alias.ac "commit ${GPG_SIGN} --all ${SIGNOFF} --verbose"          # add and commit
    git config --global alias.aca "commit ${GPG_SIGN} --all --amend ${SIGNOFF} --verbose" # add, amend and commit
    git config --global alias.ama 'am --abort'
    git config --global alias.amc 'am --continue'
    # shellcheck disable=SC2016
    git config --global alias.aml '!bash -c "curl -sL ${1} | git am"' # am from patch url
    git config --global alias.ams "am ${GPG_SIGN} ${SIGNOFF}"         # am signoff
    git config --global alias.ap 'apply -3 -v'
    # shellcheck disable=SC2016
    git config --global alias.apl '!bash -c "curl -sL ${1} | git apply -v"' # apply from patch url
    git config --global alias.b 'branch --verbose'
    git config --global alias.bd 'branch --delete --force'
    git config --global alias.bn 'rev-parse --abbrev-ref HEAD' # branch name
    git config --global alias.bm 'branch --move'
    git config --global alias.bu 'branch --unset-upstream'
    git config --global alias.c "commit ${GPG_SIGN} ${SIGNOFF} --verbose"
    git config --global alias.ca "commit ${GPG_SIGN} --amend ${SIGNOFF} --verbose"                           # commit ammend
    git config --global alias.cad "!git commit ${GPG_SIGN} --amend ${SIGNOFF} --date=\"\$(date)\" --verbose" # commit amend date
    git config --global alias.cb 'rev-parse --abbrev-ref HEAD'                                               # current branch
    git config --global alias.cf 'diff --name-only --diff-filter=U'                                          # conflicts
    git config --global alias.ch 'checkout'
    git config --global alias.cl 'clean -fxd'
    git config --global alias.cp "cherry-pick ${GPG_SIGN} ${SIGNOFF}"
    git config --global alias.cpa 'cherry-pick --abort'
    git config --global alias.cpc 'cherry-pick --continue'
    git config --global alias.cpe "cherry-pick --edit ${SIGNOFF}"
    git config --global alias.cpq 'cherry-pick --quit'
    git config --global alias.cps 'cherry-pick --skip'
    git config --global alias.dc 'describe --contains'
    git config --global alias.dfs 'diff --staged'
    git config --global alias.dfss 'diff --shortstat'
    git config --global alias.dh 'diff HEAD'
    git config --global alias.dhc 'reset --hard HEAD^'
    git config --global alias.f 'fetch'
    git config --global alias.fa 'fetch --all'
    git config --global alias.fixes 'show -s --format="Fixes: %h (\"%s\")"'
    git config --global alias.fm "commit ${GPG_SIGN} --file /tmp/mrg-msg" # finish merge
    git config --global alias.fp 'format-patch'
    git config --global alias.lo 'log --oneline'
    git config --global alias.ma 'merge --abort'
    git config --global alias.mc 'merge --continue'
    # shellcheck disable=SC2016
    git config --global alias.mfc '!git log --format=%H --committer="$(git config --get user.name) <$(git config --get user.email)>" "$(git log --format=%H -n 150 | tail -n1)".. | tail -n1'
    git config --global alias.pr 'pull-request'
    git config --global alias.psu 'push --set-upstream'
    # shellcheck disable=SC2016
    git config --global alias.ra '!f() { for i in $(git cf); do git rf $i; done }; f' # reset all conflicts
    git config --global alias.rb "rebase ${GPG_SIGN}"
    git config --global alias.rba 'rebase --abort'
    git config --global alias.rbc 'rebase --continue'
    git config --global alias.rbs 'rebase --skip'
    # shellcheck disable=SC2016
    git config --global alias.rf '!bash -c "git reset -- ${1} &>/dev/null && git checkout -q -- ${1}"' # reset file
    # shellcheck disable=SC2016
    git config --global alias.rfl '!bash -c "git reset -- ${1} && git checkout -- ${1}"' # reset file (loud)
    git config --global alias.rh 'reset --hard'
    git config --global alias.rma 'remote add'
    # shellcheck disable=SC2016
    git config --global alias.rmsu 'remote set-url'
    git config --global alias.rmv 'remote -v'
    git config --global alias.rs 'reset --soft'
    git config --global alias.ru 'remote update'
    git config --global alias.rv "revert ${GPG_SIGN} ${SIGNOFF}"
    git config --global alias.s 'status'
    git config --global alias.sh 'show --first-parent'
    git config --global alias.shf 'show --first-parent --format=fuller'
    git config --global alias.shm 'show --no-patch'
    git config --global alias.shmf 'show --format=fuller --no-patch'
    git config --global alias.sql 'show --format="Author: %aN <%ae> %nDate: %ad %n%n  %w(0,2,4)%B%n" --no-patch' # squash commit msg format
    git config --global alias.ss 'status --short --branch'
    git config --global alias.us 'reset HEAD'
); }

git_plugins() {
    # https://github.com/dandavison/delta
    if command -v delta &>/dev/null; then
        git config --global core.pager delta
        git config --global interactive.diffFilter "delta --color-only"
        git config --global merge.conflictstyle diff3
        git config --global diff.colorMoved default

        # delta config
        git config --global delta.light false
        git config --global delta.line-numbers true
        git config --global delta.navigate true
        git config --global delta.features mellow-barbet # theme
    fi
}

# Initial git config setup
git_setup() { (
    git config --global user.name "Saurabh Charde"
    git config --global user.email "saurabhchardereal@gmail.com"
    git config --global credential.helper 'cache --timeout=3600'
    git config --global pull.rebase false
    git config --global init.defaultBranch main

    gpg_setup
    git_aliases
    git_plugins
); }
