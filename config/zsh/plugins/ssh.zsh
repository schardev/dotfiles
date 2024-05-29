# export SSH_ENV to query ssh state
export SSH_ENV="${HOME}/.ssh/ssh-env"

start_ssh_agent() {
    echo "Initialising new SSH agent..."

    ssh-agent -s | sed 's/^echo/#echo/' >"${SSH_ENV}"
    chmod 0600 "${SSH_ENV}"
    source "${SSH_ENV}"

    # Disable passphrase dialog box when running in GUI mode (good 'ol tty ftw)
    export SSH_ASKPASS_REQUIRE=never

    # Add all ssh keys in ~/.ssh
    ssh-add
}

# Start `ssh-agent` if not already
if [[ -f "${SSH_ENV}" ]]; then
    source "${SSH_ENV}" >/dev/null
    pgrep -g "${SSH_AGENT_PID}" >/dev/null || {
        start_ssh_agent
    }
else
    start_ssh_agent
fi
