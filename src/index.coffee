nunjucks = require 'nunjucks'
fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'
_ = require 'lodash'

module.exports = class nunjucksBrunchPlugin
  brunchPlugin: yes
  type: 'template'
  extension: 'html'
  nunjucksOptions: {}

  publicPath: 'public'
  templatePath: 'app/views'
  projectPath: path.resolve process.cwd()

  filePatterns: /^app(\/|\\)views(\/|\\).*.html$/

  constructor: ( @config ) ->
    @configure()

  configure: ->
    if @config.plugins?.nunjucks?
      options = @config?.plugins?.nunjucks or @config.plugins.nunjucks
    else if @config.plugins?.nunjucks?
      options = @config?.plugins?.nunjucks or @config.plugins.nunjucks
    else
      options = {}

    if options.filePatterns?
      @filePatterns = options.filePatterns

    if options.templatePath?
      @templatePath = options.templatePath

    if options.path?
      @publicPath = options.path
    else if @config.paths?.public?
      @publicPath = @config.paths.public

    if options.nunjucks?
      @nunjucksOptions = options.nunjucks
    else
      @nunjucksOptions = _.omit options, 'filePatterns', 'path'

  makeOptions: ( data ) ->
    # Allow for default data in the nunjucks options hash
    if @nunjucksOptions.locals?
      locals = _.extend {}, @nunjucksOptions.locals, data
    else
      locals = data

    # Allow for custom options to be passed to nunjucks
    options = _.extend {}, @nunjucksOptions,
      locals: data

  templateFactory: ( data, options, templatePath, callback ) ->
    try
      env = new nunjucks.Environment ( new nunjucks.FileSystemLoader ( path.dirname templatePath ) )
      template = env.renderString data, options
    catch e
      error = e

    callback error, template

  compile: ( data, originalPath, callback ) ->
    templatePath = path.resolve originalPath
    relativePath = path.relative @projectPath, templatePath

    options = _.extend {}, @nunjucksOptions
    options.filename ?= relativePath

    successHandler = ( error, template ) =>
      if error?
        callback error
        return

      if relativePath.length
        publicPath = path.join @projectPath, @publicPath
        outputPath = relativePath.replace @templatePath, ''
        outputPath = path.join publicPath, outputPath
        outputDirectory = path.dirname outputPath

        # TODO: Save this block from an eternity in callback hell.
        mkdirp outputDirectory, ( err ) ->
          if err
            callback err, null
          else
            fs.writeFile outputPath, template, ( err, written, buffer ) ->
              if err
                callback err, null
              else
                callback()

      else
        callback null, "module.exports = #{template};"

    @templateFactory data, options, templatePath, successHandler