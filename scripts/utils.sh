# Disable unused variables warnings
# shellcheck disable=SC2034

# Colors
RST='\033[0m'
RED='\033[0;31m'
LGR='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'
CYN='\033[1;36m'

# Print formatted message with colors
pr_info() { echo -e "${2:-${BLU}}" " ${1}" "${RST}"; }
pr_warn() { echo -e "${YEL}" " ${1}" "${RST}"; }
pr_succ() { echo -e "${LGR}" " ${1}" "${RST}"; }
pr_err() { echo -e "${RED}" " ${1}" "${RST}" >&2; }

# Prints a formatted header to point out what is being done to the user
header() {
    BORDER="====$(for _ in $(seq ${#1}); do printf '='; done)===="
    printf '\n%b%s\n%s\n%s%b\n\n' "${2:-${LGR}}" "${BORDER}" "    ${1}    " "${BORDER}" "${RST}"
}
