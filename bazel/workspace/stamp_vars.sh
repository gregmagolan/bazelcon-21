#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# This script is called by Bazel when --workspace_status_command points to it
# Bazel uses this to get version control info to stamp onto release artifacts.
# Read more: https://docs.bazel.build/versions/master/user-manual.html#flag--workspace_status_command

function get_current_sha() {
  git rev-parse HEAD
}

function has_local_changes() {
  if [[ $(git status --porcelain) ]]; then
    echo dirty
  else
    echo clean
  fi
}

function get_current_git_user() {
  echo "$(git config user.name) <$(git config user.email)>"
}

# "volatile" keys, these will not cause a re-build because they're assumed to change on every build
# and its okay to use a stale value in a stamped binary
echo "BUILD_TIME $(date "+%Y-%m-%d %H:%M:%S %Z")"
# "stable" keys, should remain constant over rebuilds, therefore changed values will cause a
# rebuild of any stamped action that uses ctx.info_file or genrule with stamp = True
# Note, BUILD_USER is automatically available in the stable-status.txt, it matches $USER
echo "STABLE_BUILD_GIT_USER $(get_current_git_user)"
echo "STABLE_BUILD_SCM_LOCAL_CHANGES $(has_local_changes)"
echo "STABLE_BUILD_SCM_SHA $(get_current_sha)"
