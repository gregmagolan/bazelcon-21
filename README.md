# bazelcon-21

Example repository for Building Web Applications with Bazel talk at BazelCon'21.

These examples are for demonstration purposes and should not be considered
production ready.

## Windows support

The examples in this repository are NOT testing or expected to build on Windows.
Windows support for these examples would require additional provisions to handle
difference in running bazel on Windows including sandboxing, runfiles & path
slash differences.

## Formatting/linting

We suggest using a pre-commit hook to automate this. First
[install pre-commit](https://pre-commit.com/#installation), then run

```shell
pre-commit install
pre-commit install --hook-type commit-msg
```
