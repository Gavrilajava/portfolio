module.exports = api => {

  const config = {
    plugins: [
      ["@babel/plugin-transform-react-jsx", { "runtime": "automatic" }],
      ["@babel/plugin-transform-typescript", { "isTSX": true, "allExtensions": true }],
    ]
  }
  if (api?.env && api.env('test')) {
    config['presets'] = ['@babel/preset-env']
  }

  return config
};