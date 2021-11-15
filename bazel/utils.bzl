"""General utility functions"""

def path_to_root():
    """Returns the path to the root of the repository from the current package

    Returns:
        Path to the repository root
    """
    return "/".join([".."] * len(native.package_name().split("/")))
