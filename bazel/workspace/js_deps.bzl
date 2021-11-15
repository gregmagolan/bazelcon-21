"""Initialize and/or fetch additional javascript dependencies"""

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")
load("@build_bazel_rules_nodejs//toolchains/esbuild:esbuild_repositories.bzl", "esbuild_repositories")
load("@io_bazel_rules_sass//sass:sass_repositories.bzl", "sass_repositories")
load("//bazel:constants.bzl", "NODE_VERSION")

def js_deps():
    """Initialize and/or fetch additional javascript dependencies"""

    # Setup the Node.js toolchain
    node_repositories(node_version = NODE_VERSION)

    # Load esbuild binaries
    esbuild_repositories(npm_repository = "npm")

    # Setup Bazel managed npm dependencies with the yarn_install rule.
    # The name of this rule should be set to `npm` so that bazel rules
    # can find the dependencies by default in the `@npm` workspace.
    yarn_install(
        name = "npm",
        package_json = "//:package.json",
        yarn_lock = "//:yarn.lock",
        exports_directories_only = True,
        symlink_node_modules = False,
        data = ["//bazel/workspace:yarn-postinstall.sh"],
        quiet = False,
    )

    # Setup the rules_sass toolchain
    sass_repositories()
