## nunjucks-brunch [![](https://img.shields.io/travis/PxlBuzzard/nunjucks-brunch.svg)](https://travis-ci.org/PxlBuzzard/nunjucks-brunch) [![](https://img.shields.io/npm/v/nunjucks-brunch.svg)](https://www.npmjs.com/package/nunjucks-brunch)  [![](https://img.shields.io/codeclimate/coverage/github/PxlBuzzard/nunjucks-brunch.svg)](https://codeclimate.com/github/PxlBuzzard/nunjucks-brunch)

Adds [nunjucks](https://mozilla.github.io/nunjucks/) support to [brunch](http://brunch.io).

## Usage
Install the plugin via npm with `npm install nunjucks-brunch --save`.

Or, do manual install:

* Add `"nunjucks-brunch": "x.y.z"` to `package.json` of your brunch app.
  Pick a plugin version that corresponds to your minor (y) brunch version.
* If you want to use git version of plugin, add
`"nunjucks-brunch": "git@github.com:PxlBuzzard/nunjucks-brunch.git"`.

### Brunch plugin settings
If customization is needed or desired, settings can be modified in your brunch
config file (such as `config.coffee`):

* __templatePath__: Default `app/views`. The top-level directory where your nunjucks templates are stored.  __Note:__ Windows users will want to use `app\\views`.

* __pathReplace__: _(RegExp)_ Default `/^app(\/|\\)views(\/|\\).*.html$/`. Sets the regular expression applied against the source file path to create the module name. Matched characters are removed.

* __Custom Variables__: Any variable you define can be referenced in a nunjucks template. For example, `{{ github_username }}` would output to `PxlBuzzard` using the example below.

**Example:**
```coffeescript
exports.config =
  ...
  plugins:
    nunjucks:
      github_username: 'PxlBuzzard'
```
