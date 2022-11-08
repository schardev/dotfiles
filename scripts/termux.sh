#!/data/data/com.termux/files/usr/bin/bash
#
# SPDX-License-Identifier: MIT
#
# Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>
#

CONFIG_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"/..
source "$CONFIG_DIR"/scripts/utils.sh
source "$CONFIG_DIR"/scripts/git-setup.sh

# Install packages
termux_install_packages() {
    # List of packages to install
    local packages=(
        clang
        exa
        gh
        gnupg
        jq
        lua-language-server
        ncurses-utils
        neovim
        nodejs
        openssh
        sheldon
        shellcheck
        shfmt
        stylua
        zoxide
        zsh
    )

    # Update package lists and update preinstalled packages
    pkg update -y && pkg upgrade -y

    pr_info "Installing packages ..."
    pkg install --no-install-recommends -y "${packages[@]}"
}

# Theme
termux_setup_theme() {
    # use Dracula color scheme & Hack font by default
    pr_info "Setting up theme ..."
    curl -o "$HOME"/.termux/colors.properties https://raw.githubusercontent.com/catppuccin/termux/main/Mocha/colors.properties
    cp "$CONFIG_DIR"/etc/Hack.ttf "$HOME"/.termux/font.ttf
}

# Setup dotfiles
termux_setup_dotfiles() {
    pr_info "Setting up dotfiles ..."

    # Settings I use for moi setup
    [[ ! -d ~/.termux ]] && mkdir ~/.termux
    echo "extra-keys = [['ESC','SHIFT','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >~/.termux/termux.properties

    # Make zsh follow $XDA_CONFIG_DIR
    echo "export ZDOTDIR=~/.config/zsh" >"${HOME}"/.zshenv
    [[ ! -d ~/.config ]] && mkdir "${HOME}"/{.config,.sheldon}
    ln -sf "$CONFIG_DIR"/config/zsh "${HOME}"/.config/zsh
    ln -sf "$CONFIG_DIR"/config/nvim "${HOME}"/.config/nvim
    ln -sf "$CONFIG_DIR"/config/zsh/plugins.toml "${HOME}"/.sheldon
}

termux_setup_env() {
    termux_install_packages
    termux_setup_dotfiles
    termux_setup_theme
    git_setup
    chsh -s zsh # Switch shell to zsh
    pr_succ "Setup done!"
}
