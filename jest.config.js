const { pathsToModuleNameMapper } = require('ts-jest');
const { compilerOptions } = require('./tsconfig');

const config = {
  verbose: true,
  "testPathIgnorePatterns": [
    "node_modules/",
    "vendor/javascript"
  ],
  "testEnvironment": "jsdom",
  "moduleDirectories": [
    "node_modules",
    "app/javascript"
  ],
  moduleNameMapper: pathsToModuleNameMapper(compilerOptions.paths, { prefix: '<rootDir>/app/' } ),

  "collectCoverage": true,
  "coverageReporters": [
    "text",
    "html"
  ],
  "coverageDirectory": "coveragejs"
};

module.exports = config;