"""Initialize and/or fetch additional docker dependencies"""

load("@io_bazel_rules_docker//repositories:go_repositories.bzl", container_go_deps = "go_deps")
load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("//bazel:constants.bzl", "NODE_VERSION")
load("//bazel/workspace:container_pull.bzl", "container_pull")

def docker_deps():
    """Initialize and/or fetch additional docker dependencies"""

    # Setup toolchain for building container images.
    # NB: Docker toolchain uses rules_go rules so we must initialize its deps as well
    container_repositories()
    go_rules_dependencies()
    go_register_toolchains(version = "1.17.1")
    container_go_deps()

    container_pull(
        name = "node-buster-slim",
        registry = "index.docker.io",
        repository = "node",
        tag = "%s-buster-slim" % NODE_VERSION,
    )
