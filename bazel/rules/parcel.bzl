"""Wrapper macro around parcel cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@npm//parcel-bundler:index.bzl", _parcel = "parcel")

def parcel(name, entry_html, data = [], **kwargs):
    """Wrapper macro around parcel cli"""
    _parcel(
        name = name,
        args = [
            "build",
            "%s/$(execpath %s)" % (path_to_workspace_root(), entry_html),
            "--out-dir=%s/$(@D)" % path_to_workspace_root(),
        ],
        chdir = native.package_name(),
        data = data + [entry_html],
        output_dir = True,
    )
