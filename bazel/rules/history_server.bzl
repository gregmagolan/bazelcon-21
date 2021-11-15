"""Wrapper macro around history-server cli"""

load("@npm//history-server:index.bzl", _history_server = "history_server")

def history_server(name, root, port, **kwargs):
    """Wrapper macro around history_server cli"""
    _history_server(
        name = name,
        args = [
            "-a",
            "$(rootpath %s)" % root,
            "-p",
            "%s" % port,
        ],
        data = [root],
        **kwargs
    )
