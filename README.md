# bazelcon-21

Example repository for
[Building Web Applications with Bazel](https://docs.google.com/presentation/d/10qqLig5BHZVCKyJi-vLCbUg3LLDd0WJoUl1R3ghDQWI/edit?usp=sharing)
talk at
[BazelCon'21](https://opensourcelive.withgoogle.com/events/bazelcon2021).

These examples are for demonstration purposes and should not be considered
production ready.

The purpose of this repository is to demonstrate how Bazel can run web build and
test tools in general and not to show how best to use it with any one tool.

To this end, there are examples of building & testing with a wide range of tools
include:

- [Angular CLI](https://angular.io/cli)
- [Jest](https://jestjs.io/)
- [Next.js](https://nextjs.org/)
- [Parcel](https://parceljs.org/)
- [Snowpack](https://www.snowpack.dev/)
- [SWC](https://github.com/swc-project/swc) (react & nestjs examples)
- [Vite](https://vitejs.dev/)
- [Vue](https://vuejs.org/)
- [Webpack CLI](https://webpack.js.org/api/cli/)

Notably missing and to be added soon are:

- React app transpiled and bundled with discrete
  [esbuild](https://esbuild.github.io/) targets
- Angular app transpiled with discrete
  [ngc](https://angular.io/guide/angular-compiler-options) steps and bundled
  with [esbuild](https://esbuild.github.io/)

Some TODOs are littered throughout BUILD files for targets to be added in the
future.

## How to build & test

First [install bazelisk](https://github.com/bazelbuild/bazelisk#installation) on
your machine.

After that, from a fresh clone of the repository you can build all target and
run all tests with,

```
bazel test //...
```

Note: The karma tests in the Angular CLI example are not fully hermetic as they
rely on a locally installed Chrome browser. It is possible to make the Chrome
dependency hermetic by passing a Bazel provisioned Chrome binary for karma to
use.

There are some applications & sites that can be served with bazel run:

### React

#### Built with SWC

`bazel run //examples/react:serve` serves a react application built with SWC at
`http://localhost:8080/`

#### Built with Snowpack

`bazel run //examples/snowpack:serve` serves a react application built with
snowpack at `http://localhost:8080/`

#### Built with Vite

`bazel run //examples/vite:serve` serves a react application built with vite at
`http://localhost:8080/`

#### Built with Webpack

`bazel run //examples/webpack-cli:serve_development` serves a react application
built with the webpack cli in development mode at `http://localhost:8080/`

`bazel run //examples/webpack-cli:serve_production` serves a react application
built with the webpack cli in production mode at `http://localhost:8080/`

### Angular

`bazel run //examples/angular-cli:start` serves an angular application built
with the angular cli `http://localhost:4200/`

### Parcel

`bazel run //examples/parcel:serve` serves a parcel built site at
`http://localhost:3000/`

## Windows support

The examples in this repository are NOT testing or expected to build on Windows.
Windows support for these examples would require additional provisions to handle
difference in running bazel on Windows including sandboxing, runfiles & path
slash differences.
