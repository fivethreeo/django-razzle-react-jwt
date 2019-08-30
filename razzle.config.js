'use strict';
const path = require('path');
const LoadablePlugin = require('@loadable/webpack-plugin')

module.exports = {
  modify: (defaultConfig, { target }) => {
    const config = defaultConfig;

    if (target === 'web') {
      config.plugins.unshift(
        new LoadablePlugin({ // add @loadable/webpack-plugin
          writeToDisk: {
            filename: path.resolve('./build/'),
          }
        })
      );
    }

    if (target === 'node') {
      config.entry.unshift('cross-fetch/polyfill'); // add cross-fetch/polyfill for apollo
    }

    return config;
  },

  plugins: [{
      name: 'typescript',
      options: {
        useBabel: true,
        tsLoader: {
          transpileOnly: true,
          experimentalWatchApi: true,
        },
        forkTsChecker: {
          tsconfig: './tsconfig.json',
          tslint: './tslint.json',
          watch: './src',
          typeCheck: true,
        },
      },
    }, 'scss']
};
