module.exports = {
  presets: ['@babel/preset-env'],
  plugins: [
    ["@babel/plugin-transform-react-jsx", { "runtime": "automatic" }],
    ["@babel/plugin-transform-typescript", { "isTSX": true, "allExtensions": true }],
  ]
};