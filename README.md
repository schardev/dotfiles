## Environment Setup

This repository contains my environment setup scripts and dotfiles, in case if anyone is interested in looking at them. There will be few other scripts in this repo too that I haven't documented yet, either because I don't use them anymore and/or I'll be removing/adding more to them them soon.

### Table of Contents
- [ZSH](#ZSH)
- [Neovim](#Neovim)
- [Termux](#Termux)
---
#### ZSH
##### Installation
Make sure you have [antibody](https://github.com/getantibody/antibody) plugin manager installed in your system.
```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/env ~/env

# Since ZSH does't support XDG base directory, point zsh to ~/.config/zsh using
# $ZDOTDIR env variable (see zsh section https://wiki.archlinux.org/title/XDG_Base_Directory#Hardcoded)
echo 'export ZDOTDIR=$HOME/.config/zsh' > ${HOME}/.zshenv

# Either symlink the zsh directory to your $HOME/.config or copy the file
# (I'll just symlink them here as I'd like it to be versioned controlled by git)
ln -sf ~/env/dotfiles/zsh ~/.config/zsh
```
##### Plugins
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish shell like autosuggestions
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - Additional completion definitions for Zsh.
-  [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - ZSH port of Fish history search (up arrow)
- [fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting) - Better (customisable) syntax highlighting for ZSH
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) - Awesome ZSH prompt

#### Neovim
##### Requirements
- patched font (eg. [Powerline Fonts](https://github.com/powerline/fonts) or [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts))
- `nodejs` - For coc.nvim
- `shfmt` - _(optional)_ For formatting shell scripts
- `shellcheck` - _(optional)_ For linting shell scripts
- `clang-tools` - _(optional)_ for linting c/c++ files
##### Installation

```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/env ~/env

# Either symlink the [n]vim directory to your $HOME/.config or copy the contents
ln -sf ~/env/dotfiles/nvim ~/.config/nvim

# Open [n]vim and install plugins
nvim +PlugInstall
```
If you're not comfortable using `neovim` for whatever reasons, you can use these configs with `vim` too. Just symlink the `~/env/dotfiles/nvim` to `~/.vim` and you're good to go (though I highly recommend using `neovim`).

###### Slow scrolling?
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

##### Plugins
>Few plugins will only work with `neovim` and have been marked accordingly.

Plugin| Description
-----------------------------------------------------|----------------
[vim-fugitive](https://github.com/tpope/vim-fugitive) | Awesome git plugin
[ale](https://github.com/dense-analysis/ale) | Linter/Formarter/LSP
[coc.nvim](https://github.com/neoclide/coc.nvim) | IDE features and LSP client
[tabular](https://github.com/godlygeek/tabular) | Aligning text
[vim-airline](https://github.com/vim-airline/vim-airline) | Sexy AF statusline
[onedark.vim](https://github.com/joshdick/onedark.vim) | Onedark colorscheme
[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Shows indentation level like VSCode _`(neovim)`_
[vim-commentary](https://github.com/tpope/vim-commentary) | Commenting .. uhh .. stuff
[vim-startify](https://github.com/mhinz/vim-startify) | Start menu
[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Markdown preview
[vim-css-color](https://github.com/ap/vim-css-color) | Color preview
[vim-smoothie](https://github.com/psliwka/vim-smoothie) | Smooth scrolling
[nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) | Lua fork of NERDTree _`(neovim)`_
[bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Sax bufferline _`(neovim)`_

##### Key Bindings
>`<Leader>` is basically prefixing mapping commands with our desired character. I've set my `<Leader>` character to `,` (comma). So whenever you see `<Leader>` replace it with `,` (to change leader character see `init.vim`)

---
Global Mappings      | What It Does
-------------------- | -------------
`;`                  | Mapped to `:` (no need to keep holding shift)
`Ctrl + ↑`           | Moves window cursor up
`Ctrl + ↓`           | Moves window cursor down
`Ctrl + ←`           | Moves window cursor left
`Ctrl + →`           | Moves window cursor right
`Ctrl + Shift + ↑`   | Moves current window up
`Ctrl + Shift + ↓`   | Moves current window down
`Ctrl + Shift + ←`   | Moves current window left
`Ctrl + Shift + →`   | Moves current window right
`Ctrl + w`           | Delete current buffer
`<Leader>t`          | Toggles tab highlighting
`<Leader>s`          | Toggles search highlighting
`<Leader>n`          | Go to next buffer
`<Leader>p`          | Go to to previous buffer
`<Leader>ev`         | Edit init.vim/vimrc
`<Leader>ed`         | Edit my dotfiles
`<Leader>sv`         | source init.vim/vimrc
---

_Make sure to read respective plugin documentation if you did not understand any plugin mapping. Even if you do understand them it's still recommended to read vim docs._

- _`(ale)`_ - `ALE` specific
- _`(coc)`_ - `coc.nvim` specific
- _`(smoothie)`_ - `vim-smoothie` specific


Plugin Mappings  | What It Does
---------------- | -------------
`<Leader>f`      | ALEFix & Format _`(ale)`_
`[g` & `]g`      | Navigate `coc.nvim` diagnostics _`(coc)`_
`gd`             | Go to symbol/code definition _`(coc`)_
`gy`             | Go to type definition _`(coc)`_
`gi`             | Go to implementation _`(coc)`_
`gr`             | Go to references _`(coc)`_
`D`              | Opens vim documentation for the keyword under cursor _`(coc)`_
`<Leader>rn`     | Rename symbol/keyword _`(coc)`_
`<Leader>f`      | Format selected code _`(coc)`_ (visual mode)
`<Leader>a`      | Apply codeaction to selected region _`(coc)`_
`<Leader>qf`     | Apply autofix to problem on the current line _`(coc)`_
`<Space>a`       | CocList diagnostics _`(coc)`_
`<Space>e`       | CocList extensions _`(coc)`_
`<Space>c`       | CocList commands _`(coc)`_
`<Space>o`       | CocList outline _`(coc)`_
`<Space>s`       | CocList -I symbols _`(coc)`_
`<Space>j`       | CocNext _`(coc)`_
`<Space>k`       | CocPrev _`(coc)`_
`<Space>p`       | CocListResume _`(coc)`_
`J`              | Smoothly scroll downwards _`(smoothie)`_
`K`              | Smoothly scroll upwards _`(smoothie)`_
---
<!--
_Buffer-specific mapping will only work for specific buffers/filetype ... duh._
- _`(help)`_ - If the filetype is help

Buffer Mappings          | What It Does
------------------------ | -------------
-->

#### Termux
When I'm not on my laptop (or just too lazy to boot it up) I'll use Termux to get my stuff done. It's pretty awesome!

The script will setup termux to have [Dracula](https://github.com/dracula) colorscheme and [Hack](https://github.com/source-foundry/Hack) fonts by default. It also does my git and dotfiles setup.
##### Installation
```bash
# Clone the repo
git clone https://github.com/saurabhchardereal/env ~/env

# Run the script
./env/scripts/termux
```
##### Packages Installed on Termux
- antibody
- nodejs
- nvim
- openssh
- gnupg
- zsh
