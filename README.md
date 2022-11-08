<h1 align="center">🏠</h1>
<p align='center'><b>~ There's no other place like <code>$HOME</code> ~</b></p>

<div align="center">
    <img alt="Lint Lua" src="https://img.shields.io/github/workflow/status/saurabhchardereal/dotfiles/Lint%20lua%20files/main?label=Lint%20Lua&style=flat-square">
    <img alt="Lint Scripts" src="https://img.shields.io/github/workflow/status/saurabhchardereal/dotfiles/Lint%20shell%20scripts/main?label=Lint%20Scripts&style=flat-square">
</div>

### Current Setup

- **WM:** [bspwm](https://github.com/baskerville/bspwm)
- **OS:** [Arch Linux](https://archlinux.org)
- **Terminal:** [Wezterm](https://github.com/wez/wezterm)
- **Shell:** [zsh](https://wiki.archlinux.org/index.php/Zsh)
- **Compositor:** [picom](https://github.com/ibhagwan/picom)
- **Editor:** [neovim](https://github.com/neovim/neovim)
- **Bar:** [Polybar](https://github.com/polybar/polybar)
- **Browser:** [firefox](https://www.mozilla.org/en-US/firefox)
- **File Manager:** [thunar](https://github.com/xfce-mirror/thunar)
- **Application Launcher:** [rofi](https://github.com/davatorium/rofi)
- **Color Scheme:** [catppuccin](https://github.com/catppuccin)

See screenshots [here](https://imgur.com/a/uiUZcQc).

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
git clone https://github.com/saurabhchardereal/dotfiles ~/dotfiles

# Symlink zsh directory to $HOME/.config/zsh and zsh/.zshenv to $HOME
ln -sf ~/dotfiles/config/zsh{,/.zshenv} ~/{.config/zsh,}

# restart shell/terminal
exec zsh
```

### Neovim

#### Requirements

- patched font (eg. [Powerline Fonts](https://github.com/powerline/fonts) or [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts))
- `clang` or `gcc` - For [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- `wget` or `curl` and `gzip` or `tar` - For fetching language servers
- `nodejs` and `npm` - For installing language servers

##### Optional Dependencies

- `rg` and `fd` - For [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- `eslint_d`, `shellcheck` - For linting
- `prettierd`, `shfmt`, `stylua` - For formatting

#### Installation

```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/dotfiles ~/dotfiles

# Either symlink the nvim directory to your $HOME/.config or copy the contents
ln -sf ~/dotfiles/config/nvim ~/.config/nvim

# Open nvim and it'll automatically start installing plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

> **Note**  
> Check [this](./config/nvim/lua/plugins.lua) file for the list of plugins that'll be installed automatically.

<details>
  <summary> Slow scrolling? </summary>

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

</details>

### Termux

When I'm not on my laptop (or just too lazy to boot it up) I use [Termux](https://github.com/termux) to get my stuff done. It's pretty awesome!

The script will setup termux to have [Catppuccin](https://github.com/catppuccin) colorscheme and [Hack](https://github.com/source-foundry/Hack) fonts by default. It also does my git and dotfiles setup.

#### Installation

```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/dotfiles ~/dotfiles

# Run the script
./dotfiles/scripts/termux
```
