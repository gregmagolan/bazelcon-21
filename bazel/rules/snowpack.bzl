"""Wrapper macro around snowpack cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@build_bazel_rules_nodejs//:index.bzl", "npm_package_bin")

def snowpack_build(name, **kwargs):
    """Wrapper macro around snowpack cli"""
    args = kwargs.pop("args", [])
    args = [
        "build",
        # --out-dir is parsed out by custom tool entry point & not forwarded to the underlying tool cli
        "--out-dir",
        "%s/$(@D)" % path_to_workspace_root(),
    ] + args

    npm_package_bin(
        name = name,
        args = args,
        chdir = native.package_name(),
        output_dir = True,
        # Use a custom tool binary which uses a customized entry point
        # tool = ":%s_entry_bin" % name,
        tool = "//bazel/rules:snowpack-bazel-entry",
        **kwargs
    )
