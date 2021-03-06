module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true
  },
  extends: ["eslint:recommended", "plugin:react/recommended"],
  globals: {
    Atomics: "readonly",
    SharedArrayBuffer: "readonly"
  },
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 2018,
    sourceType: "module"
  },
  parser: "babel-eslint",
  plugins: ["react"],
  rules: {
    curly: [2, "multi-line"],
    semi: ["error", "always"],
    quotes: ["error", "double"]
  },
  settings: {
    react: {
      version: "detect"
    }
  }
};
