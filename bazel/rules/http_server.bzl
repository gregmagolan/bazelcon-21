"""Wrapper macro around http-server cli"""

load("@npm//http-server:index.bzl", _http_server = "http_server")

def http_server(name, root, port, **kwargs):
    """Wrapper macro around http_server cli"""
    _http_server(
        name = name,
        args = [
            "$(rootpath %s)" % root,
            "-p",
            "%s" % port,
        ],
        data = [root],
        **kwargs
    )
