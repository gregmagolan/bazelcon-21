const config = {
  mount: {
    public: '/',
    src: '/dist',
  },
  plugins: ['@snowpack/plugin-react-refresh', '@snowpack/plugin-dotenv'],
};

if (process.env['BAZEL_TARGET']) {
  config.buildOptions = {
    out: process.env['SNOWPACK_OUTDIR'],
  };
}

module.exports = config;
