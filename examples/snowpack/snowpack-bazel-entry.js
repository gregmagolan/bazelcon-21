// based on snowpack/index.bin.js

// check minimum node version
const ver = process.versions.node;
const majorVer = parseInt(ver.split('.')[0], 10);
if (majorVer < 10) {
  console.error(
    'Node version ' +
      ver +
      ' is not supported, please use Node.js 10.0 or higher.',
  );
  process.exit(1);
}

// strip out --out-dir param and pass it to snowpack via SNOWPACK_OUTDIR env var
// TODO(contrib): add this param upstream in snowpack so this is no longer needed
const inputArgs = process.argv.slice(2);
const toolArgs = process.argv.slice(0, 2);
let outDir = '';
while (inputArgs.length) {
  const arg = inputArgs.shift();
  switch (arg) {
    case '--out-dir':
      outDir = inputArgs.shift();
      break;
    default:
      toolArgs.push(arg);
  }
}
if (!outDir) {
  throw new Error('--out-dir <output_directory> required!');
}
process.env['SNOWPACK_OUTDIR'] = outDir;

// run snowpack
const cli = require('snowpack/lib/cjs/index.js');
const run = cli.run || cli.cli || cli.default;
run(toolArgs).catch(function (error) {
  console.error(`
${error.stack || error.message || error}
`);
  process.exit(1);
});
