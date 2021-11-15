"""Wrapper macros around the angular cli architect layer"""

load("@aspect_bazel_lib//lib:utils.bzl", "path_to_workspace_root")
load(
    "@npm//@angular-devkit/architect-cli:index.bzl",
    _architect = "architect",
    _architect_test = "architect_test",
)

def angular_cli_build(name, target, **kwargs):
    """Wrapper macro around the angular cli architect layer

    Args:
        name: name
        target: target
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        target,
        "--outputPath=%s/$(@D)" % path_to_workspace_root(),
    ] + args
    env = kwargs.pop("env", {})
    env["NG_BUILD_CACHE"] = "false"

    _architect(
        name = name,
        args = args,
        env = env,
        chdir = native.package_name(),
        output_dir = True,
        **kwargs
    )

def angular_cli_test(name, target, **kwargs):
    """Wrapper macro around the angular cli architect layer

    Args:
        name: name
        target: target
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [target] + args
    env = kwargs.pop("env", {})
    env["NG_BUILD_CACHE"] = "false"

    _architect_test(
        name = name,
        args = args,
        env = env,
        chdir = native.package_name(),
        **kwargs
    )

def angular_cli_run(name, target, chdir, **kwargs):
    """Wrapper macro around the angular cli architect layer

    Args:
        name: name
        target: target
        chdir: chdir
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        "--node_options=--require=./$(execpath %s)" % chdir,
        target,
    ] + args
    data = kwargs.pop("data", [])
    data.append(chdir)
    env = kwargs.pop("env", {})
    env["NG_BUILD_CACHE"] = "false"

    _architect(
        name = name,
        args = args,
        data = data,
        env = env,
        **kwargs
    )
