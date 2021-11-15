// based on @swc/cli/bin/spack.js

// strip out --entry param and pass it to tool via SWCPACK_ENTRY env var
// strip out --out-file param and pass it to tool via SWCPACK_OUTFILE env var
const inputArgs = process.argv.slice(2);
const toolArgs = process.argv.slice(0, 2);
let entry = "";
let outFile = "";
while (inputArgs.length) {
  const arg = inputArgs.shift();
  switch (arg) {
    case "--out-file":
      outFile = inputArgs.shift();
      break;
    case "--entry":
      entry = inputArgs.shift();
      break;
    default:
      toolArgs.push(arg);
  }
}
if (!entry) {
  throw new Error("--entry <entry_file> required!");
}
if (!outFile) {
  throw new Error("--out-file <output_file> required!");
}
process.env["SWCPACK_ENTRY"] = entry;
process.env["SWCPACK_OUTFILE"] = outFile;

// run tool
process.title = "spack";
process.argv = toolArgs;
require("@swc/cli/lib/spack");
