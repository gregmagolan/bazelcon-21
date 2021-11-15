const { spawnSync } = require("child_process");
const { renameSync } = require("fs");

const entry = require.resolve("next/dist/bin/next");
const inputArgs = process.argv.slice(2);
const toolArgs = [];
let outDir = "";
while (inputArgs.length) {
  const arg = inputArgs.shift();
  switch (arg) {
    case "--outDir":
      outDir = inputArgs.shift();
      break;
    default:
      toolArgs.push(arg);
  }
}
if (!outDir) {
  throw new Error("--outDir <output_directory> required!");
}
const spawnOptions = {
  stdio: [process.stdin, process.stdout, process.stderr],
  shell: process.env.SHELL,
};
const res = spawnSync(entry, toolArgs, spawnOptions);
if (res.status === 0) {
  // We move the default .next output directory to the output directory expected
  // by bazel since bundling fails when done in the bazel-out tree due to multiple
  // reacts required from web-static-sites/node_modules and bazel-out/web-static-sites/node_modules
  renameSync(".next", outDir);
}
process.exit(res.status);
