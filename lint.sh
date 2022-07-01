# SPDX-License-Identifier: MIT
#
# Copyright (C) 2021 Saurabh Charde <saurabhchardereal@gmail.com>
#
# Lint scripts using shellcheck and shfmt
set -e

# Lint bash files
find . -type f \( -executable -or -name "*.sh" \) -not -path "./.git/*" -print0 |
    while IFS= read -r -d '' file; do
        shellcheck -s bash -e SC1090,SC1091 "$file"
        shfmt -d -ci -i 4 "$file"
    done

# Check lua files format
stylua --check -f config/nvim/.stylua.toml .
