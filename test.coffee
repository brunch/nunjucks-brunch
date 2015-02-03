fs = require 'fs'
expect = require('chai').expect
nunjucks = require 'nunjucks'
Plugin = require './'

describe 'Plugin', ->
  @plugin

  beforeEach ->
    @plugin = new Plugin
      plugins:
        nunjucks:
          weak: 'So so strong'

  it 'should be an object', ->
    expect(@plugin).to.be.ok

  it 'should has #compile method', ->
    expect(@plugin.compile).to.be.an.instanceof(Function);

  it 'should pass `plugins.nunjucks` data to the template', (done) ->
    content = '<strong>{{weak}}</strong>';
    expected = '<strong>So so strong</strong>';

    @plugin.compile content, 'template.nunjucks', (err) ->
      expect(err).not.to.be.ok;
      result = fs.readFileSync __dirname + '/public/template.nunjucks', { encoding: 'UTF-8' }
      expect(result).to.equal(expected);
      done()
