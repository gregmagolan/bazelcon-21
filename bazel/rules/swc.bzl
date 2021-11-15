"""Wrapper macro around the swc cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@build_bazel_rules_nodejs//:index.bzl", "npm_package_bin")
load("@npm//@swc/cli:index.bzl", _swc = "swc")

def swc_compile(name, swcrc, **kwargs):
    """Wrapper macro around the swc cli to compile a folder

    Args:
        name: name
        swcrc: swcrc
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        "--no-swcrc",
        "--source-maps",
        "--config-file",
        "%s/$(execpath %s)" % (path_to_workspace_root(), swcrc),
        "--out-dir",
        "%s/$(@D)" % path_to_workspace_root(),
    ] + args
    data = kwargs.pop("data", [])
    data.append(swcrc)

    _swc(
        name = name,
        args = args,
        chdir = native.package_name(),
        data = data,
        output_dir = True,
        **kwargs
    )

def swc_bundle(name, entry, out, **kwargs):
    """Wrapper macro around the swc cli to bundle a folder

    Args:
        name: name
        entry: entry
        out: out
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        # --entry is parsed out by custom tool entry point & not forwarded to the underlying tool cli
        "--entry",
        "%s/%s" % (path_to_workspace_root(), entry),
        # --output is parsed out by custom tool entry point & not forwarded to the underlying tool cli
        "--out-file",
        "%s/$(execpath %s)" % (path_to_workspace_root(), out),
    ] + args

    npm_package_bin(
        name = name,
        outs = [
            out,
            "%s.map" % out,
        ],
        args = args,
        chdir = native.package_name(),
        # Use a custom tool binary which uses a customized entry point
        tool = "//bazel/rules:swcpack-bazel-entry",
        **kwargs
    )

def swc_minify(name, src, out, swcrc, **kwargs):
    """Wrapper macro around the swc cli to minify a bundle

    Args:
        name: name
        src: src
        out: out
        swcrc: swcrc
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        "$(execpath %s)" % src,
        "--no-swcrc",
        "--source-maps",
        "--config-file",
        "$(execpath %s)" % swcrc,
        "--out-file",
        "$(execpath %s)" % out,
    ] + args
    data = kwargs.pop("data", [])
    data.append(swcrc)

    _swc(
        name = name,
        outs = [
            out,
            "%s.map" % out,
        ],
        args = args,
        data = data,
        **kwargs
    )
