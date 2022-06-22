# Environment Setup

This repository contains my environment setup scripts and dotfiles, in case if anyone is interested in looking at them. There will be few other scripts in this repo too that I haven't documented yet, either because I don't use them anymore and/or I'll be removing/adding more to them them soon.

### Table of Contents

- [ZSH](#ZSH)
- [Neovim](#Neovim)
- [Termux](#Termux)

---

### ZSH

#### Installation

Make sure you have [sheldon](https://github.com/rossmacarthur/sheldon) plugin manager installed in your system.

```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/env ~/env

# Since ZSH does't support XDG base directory, point zsh to ~/.config/zsh using
# $ZDOTDIR env variable (see zsh section https://wiki.archlinux.org/title/XDG_Base_Directory#Hardcoded)
echo 'export ZDOTDIR=$HOME/.config/zsh' > ${HOME}/.zshenv

# Either symlink the zsh directory to your $HOME/.config or copy the file
# (I'll just symlink them here as I'd like it to be versioned controlled by git)
ln -sf ~/env/config/zsh ~/.config/zsh

# Create sheldon plugin file symlink
mkdir ~/.config/sheldon && ln -sf ~/env/config/zsh/plugins.toml ~/.config/sheldon

# restart shell/terminal
```

#### Plugins

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish shell like autosuggestions
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - Additional completion definitions for Zsh.
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - ZSH port of Fish history search (up arrow)
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) - Better (customisable) syntax highlighting for ZSH
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) - Awesome ZSH prompt
- [zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use) - ZSH plugin that reminds you to use existing aliases

### Neovim

#### Requirements

- patched font (eg. [Powerline Fonts](https://github.com/powerline/fonts) or [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts))
- `clang` or `gcc` - For nvim-treesitter
- `nodejs` - For coc.nvim
- `shfmt` - _(optional)_ For formatting shell scripts
- `shellcheck` - _(optional)_ For linting shell scripts
- `clang-tools` - _(optional)_ for linting c/c++ files

#### Installation

```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/env ~/env

# Either symlink the nvim directory to your $HOME/.config or copy the contents
ln -sf ~/env/config/nvim ~/.config/nvim

# Open nvim and it'll automatically start installing plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

##### Slow scrolling?

You may or may not face slow scrolling with my configs. Since I keep enabled a bunch of settings which are notorious with cursor/scrolling speed you may want to disable them if you noticed any lag on your system.

```vim
" Disable cursorline and colorcolumn highlight as it is (most of the time) the main
" culprit in slowing down your scrolling
set nocursorline colorcolumn=

" Syntax highlighting can be heavy sometimes, set maximum column to read for syntax highlighting items
" NOTE: (neo)vim will stop highlighting text after this column and following
" lines may not be highlighted correctly
set synmaxcol=190
```

### Termux

When I'm not on my laptop (or just too lazy to boot it up) I'll use Termux to get my stuff done. It's pretty awesome!

The script will setup termux to have [Dracula](https://github.com/dracula) colorscheme and [Hack](https://github.com/source-foundry/Hack) fonts by default. It also does my git and dotfiles setup.

#### Installation

```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/env ~/env

# Run the script
./env/scripts/termux
```

#### Packages Installed on Termux

- `antibody`
- `clang`
- `gnupg`
- `ncurses-utils`
- `nodejs`
- `nvim`
- `openssh`
- `sheldon`
- `zsh`
