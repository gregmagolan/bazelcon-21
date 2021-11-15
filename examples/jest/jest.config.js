module.exports = {
  testEnvironment: "node",
  haste: {
    // Required to find test files under bazel runfiles
    enableSymlinks: true,
  },
  testMatch: ["**/*.test.js"],
};
