#!/bin/bash
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2020 Saurabh Charde <saurabhchardereal@gmail.com>
#

# This will output a file (missing_blobs.txt) containing a list of missing blobs
# required by their dependencies
# (source: https://github.com/joshuous/AospMissingBlobs)

SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

if [ -z "$ANDROID_PRODUCT_OUT" ]; then
    echo "Run after you build successfully for your device!"
fi

cd "$ANDROID_PRODUCT_OUT" || return 1

# Add paths to check for blobs
BLOBS_PATH="
    system/lib \
    system/lib64 \
    system/lib/vndk* \
    system/lib64/vndk* \
    system/product/lib \
    system/product/lib64 \
    vendor/lib \
    vendor/lib64 \
    vendor/bin/hw \
    system/bin/hw \
    system/apex/com.android.runtime.release/* \
    system/apex/com.android.runtime.release/*/*"

java -jar $SCRIPT_PATH/../bin/MissingBlobs.jar \
$BLOBS_PATH > missing_blobs.txt

# I don't want to see "Path is not a directory" so chop it off
sed -i '/^Path/d' missing_blobs.txt
