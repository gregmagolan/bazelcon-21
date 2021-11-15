"""Wrapper macro around nextjs cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@build_bazel_rules_nodejs//:index.bzl", "npm_package_bin")

def nextjs_build(name, **kwargs):
    """Wrapper macro around nextjs cli

    Args:
        name: name
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        "build",
        # --outDir is parsed out by custom tool entry point & not forwarded to the underlying tool cli
        "--outDir",
        "%s/$(@D)" % path_to_workspace_root(),
    ] + args
    env = kwargs.pop("env", {})
    env["NEXT_TELEMETRY_DISABLED"] = "1"  # https://nextjs.org/telemetry

    npm_package_bin(
        name = name,
        args = args,
        env = env,
        chdir = native.package_name(),
        output_dir = True,
        # Use a custom tool binary which uses a customized entry point
        # tool = ":%s_entry_bin" % name,
        tool = "//bazel/rules:nextjs-bazel-entry",
        **kwargs
    )
