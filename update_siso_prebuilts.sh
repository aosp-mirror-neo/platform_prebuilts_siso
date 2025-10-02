#!/bin/bash
set -eux

cd "$(dirname $0)"

if ! git diff HEAD --quiet; then
    echo "must be run with a clean prebuilts/siso project"
    exit 1
fi

version=${1:-latest}
# Turn the argument given into a git revision.
hash=$(cipd describe build/siso/linux-amd64 -version ${version} | sed -n '/^  git_revision:/{s/.*revision://p;q}')
if [[ -z "${hash}" ]]; then
  hash=$(cipd describe build/siso/linux-amd64 -version git_revision:${version} | sed -n '/^  git_revision:/{s/.*revision://p;q}')
fi
if [[ -z "${hash}" ]]; then
  echo "Could not find revision '${version}'" >& 2
  exit 1
fi

# Update siso.ensure
sed -i "/build\/siso.*git_revision:[0-9a-f]*$/s/\\(git_revision\\):[0-9a-f]*\$/\1:${hash}/" siso.ensure

cipd ensure-file-resolve -ensure-file siso.ensure
# This avoids cipd creating `.cpid` and using symlinks.
cipd export -root . -ensure-file siso.ensure
