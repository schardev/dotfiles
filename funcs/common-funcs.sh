# SPDX-License-Identifier: MIT
#
# Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>
#
# Helper functions

# Export SCRIPT_DIR
if [[ -n $BASH ]]; then
    SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
elif [[ -n $ZSH_VERSION ]]; then
    SCRIPT_DIR=$(dirname "$(readlink -f "${0}")")
else
    echo "No known shell found! Exiting ..."
    sleep 3 && exit 1
fi
SCRIPT_DIR=$(dirname "${SCRIPT_DIR}")
export SCRIPT_DIR

# Colors
RST='\033[0m'
RED='\033[0;31m'
LGR='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'
CYN='\033[1;36m'
export RST RED LGR YEL BLU CYN

# Print formatted message with colors
pr_info() { echo -e "${2:-${BLU}}" "≡≡≡ ${1} ≡≡≡" "${RST}"; }
pr_warn() { echo -e "${YEL}" "■ ${1} ■" "${RST}"; }
pr_succ() { echo -e "${LGR}" "▓▒░ ${1} ░▒▓" "${RST}"; }
pr_err() { echo -e "${RED}" "!!! ${1} !!!" "${RST}" >&2; }

# Prints a formatted header to point out what is being done to the user
header() {
    BORDER="====$(for _ in $(seq ${#1}); do printf '='; done)===="
    printf '\n%b%s\n%s\n%s%b\n\n' "${2:-${LGR}}" "${BORDER}" "    ${1}    " "${BORDER}" "${RST}"
}

# SSH
SSH_ENV="${HOME}/.ssh/ssh-env"
function start_agent {
    echo "Initialising new SSH agent..."
    ssh-agent -s | sed 's/^echo/#echo/' >"${SSH_ENV}"
    chmod 0600 "${SSH_ENV}"
    source "${SSH_ENV}"

    # Disable passphrase dialog box when running in GUI mode (good 'ol tty ftw)
    export SSH_ASKPASS_REQUIRE=never
    ssh-add
}

# vim: filetype=sh