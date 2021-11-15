"""Wrapper macro around vite cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@npm//vite:index.bzl", _vite = "vite")

def vite(name, **kwargs):
    """Wrapper macro around vite cli"""
    args = kwargs.pop("args", [])
    args = [
        "build",
        "--outDir=%s/$(@D)" % path_to_workspace_root(),
    ] + args

    _vite(
        name = name,
        args = args,
        chdir = native.package_name(),
        output_dir = True,
        **kwargs
    )
