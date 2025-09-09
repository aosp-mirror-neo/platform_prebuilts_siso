#!/bin/bash
set -eux

cd "$(dirname $0)"

if ! git diff HEAD --quiet; then
    echo "must be run with a clean prebuilts/siso project"
    exit 1
fi

readonly tmpdir=$(mktemp -d)

cipd ensure-file-resolve -ensure-file siso.ensure
# This avoids cipd creating `.cpid` and using symlinks.
cipd export -root . -ensure-file siso.ensure
