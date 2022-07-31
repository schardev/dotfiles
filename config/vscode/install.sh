source "$CONFIG_DIR"/scripts/utils.sh

code_install_extension() {
    local extensions=(
        vscodevim.vim              # vim emulation
        esbenp.prettier-vscode     # prettier
        dbaeumer.vscode-eslint     # eslint
        PKief.material-icon-theme  # material icons
        redhat.vscode-yaml         # yaml ls
        yzhang.markdown-all-in-one # markdown preview
    )

    for ext in "${extensions[@]}"; do
        pr_info "Installing ... $ext"
        code --install-extension "$ext"
    done
}

code_setup_dotfiles() {
    local code_dir="$HOME/.config/Code - OSS/User"

    # Remove stale/default configs
    rm -rf "$code_dir"/{*.json,snippets}

    # Symlink version controlled configs
    ln -sf "$CONFIG_DIR"/config/vscode/* "$code_dir"
}
