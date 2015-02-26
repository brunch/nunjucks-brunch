## nunjucks-brunch
Adds nunjucks support to [brunch](http://brunch.io).

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

## License

The MIT License (MIT)

Copyright (c) Daniel Jost (http://danieljost.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
