"""Fetch external dependencies that are required for Bazel's repository bootstrapping

This is akin to npm, in that we declare dependencies and their versions and fetch them
on demand.

Note that Bazel caches these, following the --repository_cache option
https://docs.bazel.build/versions/main/command-line-reference.html#flag--repository_cache
and this requires dependencies have a SHA256 checksum so that Bazel knows when to
invalidate the cache without accessing the network."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def repositories():
    """Download bazel external dependencies

    Dependencies downloaded may have additional bootstrapping steps that are called afterwards.
    They may also provide repository rules for fetching additional ecosystem specific deps such as npm packages
    and docker images.
    """

    http_archive(
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        ],
        sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    )

    http_archive(
        name = "aspect_bazel_lib",
        sha256 = "8c8cf0554376746e2451de85c4a7670cc8d7400c1f091574c1c1ed2a65021a4c",
        url = "https://github.com/aspect-build/bazel-lib/releases/download/v0.2.6/bazel_lib-0.2.6.tar.gz",
    )

    # Rules for building nodejs projects
    http_archive(
        name = "build_bazel_rules_nodejs",
        sha256 = "f7037c8e295fdc921f714962aee7c496110052511e2b14076bd8e2d46bc9819c",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.4.5/rules_nodejs-4.4.5.tar.gz"],
    )

    # Rules for building containers
    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
        strip_prefix = "rules_docker-0.17.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
    )

    # Rules go is a transitive dep of rules_docker but must be explicitely specified
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "2b1641428dff9018f9e85c0384f03ec6c10660d935b750e3fa1492a281a53b0f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
        ],
    )

    # Gazelle is a transtive dep of rules_go but must be explicitely specified
    http_archive(
        name = "bazel_gazelle",
        sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
        ],
    )

    # Rules for compiling scss -> css
    http_archive(
        name = "io_bazel_rules_sass",
        patch_args = ["-p1"],
        patches = [
            # Updates @bazel/work dep to 4.0.0 inside rules_sass so it is compatible
            "//bazel/workspace:patches/io_bazel_rules_sass.patch",
        ],
        sha256 = "5313032124ff191eed68efcfbdc6ee9b5198093b2b80a8e640ea34feabbffc69",
        strip_prefix = "rules_sass-1.34.0",
        urls = [
            "https://github.com/bazelbuild/rules_sass/archive/1.34.0.zip",
            "https://mirror.bazel.build/github.com/bazelbuild/rules_sass/archive/1.34.0.zip",
        ],
    )
