#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# symlink .bin folder from root node_modules to this node_modules to simplify non-bazel scripts
rm -rf "$INIT_CWD/node_modules/.bin"
ln -s "$INIT_CWD/../../node_modules/.bin" "$INIT_CWD/node_modules/.bin"
