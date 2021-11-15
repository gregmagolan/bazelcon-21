#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

if [[ -z ${BAZEL_YARN_INSTALL:-} ]]; then
    # Don't run outside of bazel
    exit 0
fi

echo "ngcc - upgrade Angular modules"

node_modules/.bin/ngcc --tsconfig ./tsconfig.json --async
