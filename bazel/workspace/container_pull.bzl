"""container_pull macro with improved API"""

load("@io_bazel_rules_docker//container:container.bzl", _container_pull = "container_pull")
load("//bazel/workspace:image_digests.bzl", "IMAGE_DIGESTS")

def container_pull(
        name,
        registry,
        repository,
        tag = None,
        digest = None,
        **kwargs):
    """container_pull macro that improves the API around tags & digests.

    This improves the API misconception when both a tag and digest are specified that the tag
    is load bearing, when it isn't.

    To prevent from users updating a tag and forgetting to update a digest, this macro allows
    for either a tag or a digest to be specified but not both. If a tag is specified, the digest
    must exist in the IMAGE_DIGESTS map in bazel/workspace/image_digests.bzl.

    Args:
        name: A unique name for this repository.
        registry: The registry from which we are pulling.
        repository: The name of the image.
        tag: The tag to lookup in the IMAGE_DIGESTS map. `tag` cannot be specified if `digest` is set.
        digest: The digest of the image to pull. `digest` cannot be specified if `tag` is set.
        **kwargs: additional args
    """

    if not digest and not tag:
        msg = """Either tag or digest must be specified in container_pull target %s.
Unpinned container_pull targets are not allowed.""" % name
        fail(msg)

    if tag:
        key = "%s:%s" % (repository, tag)

        # digest and tag cannot both be specified since tag is silently ignored if digest is set in the upstream API
        if digest:
            msg = """Both tag and digest cannot be specified in container_pull target %s.
This usage is unsafe as tag is ignored if digest is specified.
To specify a tag, add the corresponding digest to bazel/workspace/image_digests.bzl under the key %s:%s""" % (name, repository, key)
            fail(msg)

        # fail if tag is set and it is not in digests
        if not key in IMAGE_DIGESTS:
            msg = """Could not find repository:tag key %s in IMAGE_DIGESTS dict for container_pull target %s.
Please add the digest for this key to IMAGE_DIGESTS in bazel/workspace/image_digests.bzl""" % (key, name)
            fail(msg)
        digest = IMAGE_DIGESTS.get(key)

    _container_pull(
        name = name,
        registry = registry,
        repository = repository,
        digest = digest,
        **kwargs
    )
