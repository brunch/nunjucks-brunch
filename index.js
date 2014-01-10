var nunjucks = require("nunjucks");

function NunjucksCompiler(env, callback) {
  if (cfg == null) cfg = {};
  var config = cfg.plugins && cfg.plugins.nunjucks;

  if (config) {
    var overrides = config.overrides;
    if (typeof overrides === 'function') overrides(nunjucks);
    this.namespace = config.namespace;
    this.pathReplace = config.pathReplace || this.pathReplace;
    if (config.include) this.includeSettings = config.include;
  }
  this.setInclude();
}

// Figure this and the next two functions out
var NunjucksTemplate = function(template) {
  this.template = template;
};

NunjucksTemplate.prototype.render = function render(locals, callback) {
  try {
    callback(null, new Buffer(this.template.render(locals)));
  } catch (error) {
    callback(error);
  }
};

NunjucksTemplate.fromFile = function fromFile(filepath, callback) {
  var nenv = new nunjucks.Environment(new nunjucks.FileSystemLoader(env.templatesPath));
  callback(null, new NunjucksTemplate(nenv.getTemplate(filepath.relative)));
};

NunjucksCompiler.prototype.brunchPlugin = true;
NunjucksCompiler.prototype.type = 'template';
NunjucksCompiler.prototype.extension = 'html';
NunjucksCompiler.prototype.pattern = /\.html$/;
NunjucksCompiler.prototype.pathReplace = /^.*views\//;

NunjucksCompiler.prototype.compile = function(data, path, callback) {
  var error, key, ns, result, source;
  try {
    source = "Nunjucks.template(" + (nunjucks.precompile(data)) + ")";
    result = this.namespace ? (ns = this.namespace, key = path.replace(this.pathReplace, '').replace(/\..+?$/, ''), "if (typeof " + ns + " === 'undefined'){ " + ns + " = {} }; " + ns + "['" + key + "'] = " + source) : umd(source);
  } catch (_error) {
    error = _error;
  }
  if (error) return callback(error);
  return callback(null, result);
};

module.exports = NunjucksCompiler;