# SPDX-License-Identifier: MIT
#
# Copyright (C) 2021 Saurabh Charde <saurabhchardereal@gmail.com>
#
# Lint scripts using shellcheck and shfmt
set -e

# Lint bash files
for i in $(fd -t x -E etc -E config); do
    shellcheck -s bash -e SC1090,SC1091 "$i"
    shfmt -d -ci -i 4 "$i"
done

# Check lua files format
stylua --check -f config/nvim/.stylua.toml .
