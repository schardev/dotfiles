# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source common script
# TODO: retire common script and do stuff using zsh only
source "${HOME}"/env/scripts/common.sh

# Add local function definitions to fpath and autoload them when called
fpath=("$HOME/.config/zsh/functions" "${fpath[@]}")
for i in "$HOME"/.config/zsh/functions/*(:t); do
    autoload -Uz $i
done

# Initialize sheldon if installed
# https://github.com/rossmacarthur/sheldon
if command -v sheldon &>/dev/null; then
    eval "$(sheldon source)"
else
    pr_err "sheldon is not installed"
fi

#To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
