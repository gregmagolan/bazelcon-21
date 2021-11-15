"""Global mapping of repository:tag to image digests used by the container_pull macro

This mapping is intended to protect against the container_pull upstream API deficiency
where when a tag AND a digest are specified, the tag is ignored. It is easy to trip
over updating the tag and forgetting to updatee the digest and then not getting the
result you intent and also getting no warning or error from the build.

When tag is set in the container_pull in bazel/workspace/docker_deps.bzl, the macro wrapper
around the upstream container_pull looks up the digest in this dict and failed if it is
not found.
"""

# For public image repositories such as `node`, you can lookup new tags
# in https://hub.docker.com/_/<repository>?tab=tags
IMAGE_DIGESTS = {
    "node:16.13.0-buster-slim": "sha256:d024c0bf7495ab601c6905e2b74c366462eda4869ec18d941767efc2525f7360",
}
