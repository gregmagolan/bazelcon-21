"""Wrapper macro around tsc cli for typechecking"""

load("@npm//typescript:index.bzl", _tsc_test = "tsc_test")

def typecheck_test(name, tsconfig, **kwargs):
    """Wrapper macro around tsc cli for typechecking

    Args:
        name: name
        tsconfig: tsconfig
        **kwargs: **kwargs
    """
    args = kwargs.pop("args", [])
    args = [
        "-p",
        "$(execpath %s)" % tsconfig,
        "--noEmit",
    ] + args
    data = kwargs.pop("data", [])
    data.append(tsconfig)

    _tsc_test(
        name = name,
        args = args,
        data = data,
        **kwargs
    )
