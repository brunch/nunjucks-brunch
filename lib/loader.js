'use strict';
const {dirname, resolve} = require('path');
const fs = require('fs');

class BrunchLoader {
  constructor(config) {
    this.deps = [];

    Object.assign(this, config);
  }

  isRelative(path) {
    return !path.startsWith('/');
  }

  resolve(from, to) {
    const base = /^\.{1,2}/.test(to) ? dirname(from) : this.base;
    const path = resolve(base, to);

    return fs.statSync(path).isDirectory()
      ? path.replace(/[^/]+$/, `$&/${this.dir}`)
      : path;
  }

  getSource(path) {
    this.deps.push(path);
    const src = fs.readFileSync(path, 'utf-8');

    return {path, src};
  }
}

module.exports = BrunchLoader;
