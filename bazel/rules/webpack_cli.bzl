"""Wrapper macro around webpack_cli cli"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load("@npm//webpack-cli:index.bzl", _webpack_cli = "webpack_cli")

def webpack_cli(name, config, **kwargs):
    """Wrapper macro around the webpack cli

    Args:
        name: name
        config: config
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        "--config=%s/$(execpath %s)" % (path_to_workspace_root(), config),
        "--output-path=%s/$(@D)" % path_to_workspace_root(),
    ] + args
    data = kwargs.pop("data", [])
    data.append(config)

    _webpack_cli(
        name = name,
        args = args,
        data = data,
        chdir = native.package_name(),
        output_dir = True,
        **kwargs
    )
