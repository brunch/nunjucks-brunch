'use strict';
const BrunchLoader = require('./loader');
const {Environment} = require('nunjucks');

class NunjucksBrunch {
  get brunchPlugin() {
    return true;
  }

  constructor(config) {
    const {
      base = 'app',
      dir = '$&.html',
      pattern = /\.njk$/i,

      options = {},
      context = {},
      rename = String,
    } = config.plugins.nunjucks || {};

    this.loader = {
      base,
      dir,
      pattern,
    };

    Object.assign(this, {
      pattern,
      options,
      context,
      rename,
      type: 'template',
    });
  }

  compileStatic({data, path}) {
    const loader = new BrunchLoader(this.loader);
    const env = new Environment(loader, this.options);

    return {
      data: env.renderString(data, this.context, {path}),
      path: this.rename(path),
      dependencies: loader.deps,
    };
  }
}

module.exports = NunjucksBrunch;
