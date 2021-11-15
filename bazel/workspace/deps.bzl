"""Initialize and/or fetch additional external repository dependencies"""

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

def deps():
    """Initialize and/or fetch additional external repository dependencies

    This calls initialization functions on subset of external repositories require it
    """

    # Initialize skylib workspace
    bazel_skylib_workspace()
