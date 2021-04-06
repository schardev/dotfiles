# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2021 Saurabh Charde <saurabhchardereal@gmail.com>
#

##################################################
# Get cc version
#
# Arguments:
#   ${1} - compiler binary
#
##################################################
get_cc_version() {

    # Check wheather the provided binary exists, if not look that up in $PATH
    if [ ! -f "${1}" ]; then
        command -v "${1}" &>/dev/null || {
            pr_err "Compiler binary not found!"
            exit 1
        }
    fi

    # Reassure if the binary is indeed a compiler
    if ! ("${1}" --version | grep -iwEq 'clang|gcc'); then
        pr_err "Invalid compiler provided!"
        exit 1
    fi

    # All checks done! Now extract their version
    if ("${1}" --version | grep -iwq "clang"); then
        MAJOR=$(echo __clang_major__ | ${1} -E -x c - | tail -n 1)
        MINOR=$(echo __clang_minor__ | ${1} -E -x c - | tail -n 1)
        PATCHLEVEL=$(echo __clang_patchlevel__ | ${1} -E -x c - | tail -n 1)
        CC_VERSION="$(basename "${1}") version $MAJOR.$MINOR.$PATCHLEVEL"
    elif ("${1}" --version | grep -iwq "gcc"); then
        MAJOR=$(echo __GNUC__ | ${1} -E -x c - | tail -n 1)
        MINOR=$(echo __GNUC_MINOR__ | ${1} -E -x c - | tail -n 1)
        PATCHLEVEL=$(echo __GNUC_PATCHLEVEL__ | ${1} -E -x c - | tail -n 1)
        CC_VERSION="$(basename "${1}") version $MAJOR.$MINOR.$PATCHLEVEL"
    fi
    echo "${CC_VERSION}"
}
