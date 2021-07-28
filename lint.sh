# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2021 Saurabh Charde <saurabhchardereal@gmail.com>
#
# Lint scripts using shellcheck and shfmt
set -e

# Files to lint
for i in $(fd -t x -E bin -E dotfiles); do
    shellcheck -s bash -e SC1090,SC1091 "$i"
    shfmt -d -ci -i 4 "$i"
done
