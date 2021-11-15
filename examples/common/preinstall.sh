#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# run yarn install at root of repository if run in this example
yarn install --cwd "$INIT_CWD/../.."
