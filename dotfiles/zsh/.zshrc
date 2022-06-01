# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source common script
source "${HOME}"/env/funcs/common-funcs.sh

# Initialize sheldon if installed
# https://github.com/rossmacarthur/sheldon
if command -v sheldon >/dev/null; then
    eval "$(sheldon source)"
else
    pr_err "sheldon is not installed"
fi

# Initialize zoxide if installed
# https://github.com/ajeetdsouza/zoxide
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
else
    pr_warn "zoxide is not installed. Using built-in `cd`."
fi

# Start `ssh-agent` if not already and add keys (env/common)
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" >/dev/null
    pgrep -g "${SSH_AGENT_PID}" >/dev/null || {
        start_agent
    }
else
    start_agent
fi

#To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
