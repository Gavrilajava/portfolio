const babel = require("@babel/core");
const fs = require('node:fs');
const optionsObject = require("./babel.config.js");

fs.readFile('./app/javascript/react/loader.tsx', 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  console.log(optionsObject);
  console.log(babel.transformSync(data, optionsObject).code);
});
