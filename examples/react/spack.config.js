const path = require("path");

const config = {
  entry: {
    app: __dirname + "/src/Entry.ts",
  },
  target: "browser",
  output: {
    path: __dirname + "/bundle",
    name: "bundle.js",
  },
};

if (process.env["BAZEL_TARGET"]) {
  config.entry.app = path.join(process.cwd(), process.env["SWCPACK_ENTRY"]);
  config.output.path = path.join(
    process.cwd(),
    path.dirname(process.env["SWCPACK_OUTFILE"])
  );
  config.output.name = path.basename(process.env["SWCPACK_OUTFILE"]);
}

module.exports = require("@swc/core/spack").config(config);
