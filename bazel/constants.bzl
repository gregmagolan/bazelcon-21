"""Constants for use through bazel build"""

# When updating NODE_VERSION, also update node containers SHAs in
# bazel/workspace/docker_deps.bzl to match
NODE_VERSION = "16.13.0"
