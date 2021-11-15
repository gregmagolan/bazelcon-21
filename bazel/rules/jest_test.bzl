"""Wrapper macro around jest_test cli"""

load("@npm//jest-cli:index.bzl", _jest_test = "jest_test")

def jest_test(name, **kwargs):
    """Wrapper macro around jest_test cli"""
    _jest_test(
        name = name,
        args = [
            "--no-cache",
            "--no-watchman",
            "--no-colors",
            "--ci",
        ],
        chdir = native.package_name(),
        **kwargs
    )
