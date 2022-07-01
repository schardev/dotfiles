# export SSH_ENV to query ssh state
export SSH_ENV="${HOME}/.ssh/ssh-env"

# Start `ssh-agent` if not already
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" >/dev/null
    pgrep -g "${SSH_AGENT_PID}" >/dev/null || {
        start_ssh_agent
    }
else
    start_ssh_agent
fi
