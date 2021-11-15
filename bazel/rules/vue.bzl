"""Wrapper macro around vue cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@npm//@vue/cli-service:index.bzl", _vue_cli_service = "vue_cli_service")

def vue(name, **kwargs):
    """Wrapper macro around vue cli"""
    args = kwargs.pop("args", [])
    args = [
        "build",
        "--dest=%s/$(@D)" % path_to_workspace_root(),
    ] + args

    _vue_cli_service(
        name = name,
        args = args,
        chdir = native.package_name(),
        output_dir = True,
        **kwargs
    )
