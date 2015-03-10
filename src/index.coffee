'use strict'

path = require 'path'
config = require  './config'

registration = (mimosaConfig, register) ->
  register ['add', 'update', 'buildFile'], 'compile', _markdownCompiler(mimosaConfig.root, mimosaConfig.markdown), mimosaConfig.markdown.extensions

registerCommand = (program, logger, retrieveConfig) ->

_markdownCompiler = (projectRootDir, markdownConfig) ->
  marked = require 'marked'
  utilFile = require './util/file'
  markedOptions = utilFile.clonePlainObject markdownConfig.options

  if markedOptions.renderer
    markedOptions.renderer = switch typeof markedOptions.renderer
      when 'function' then new markedOptions.renderer
      when 'string' then new (if markedOptions.renderer.indexOf(path.sep) is -1 then require marked.renderer else require path.join(projectRootDir, markedOptions.renderer)).Renderer
      else markedOptions.renderer

  if markedOptions.highlight
    markedOptions.highlight = switch typeof markedOptions.highlight
      when 'string' then require path.join(projectRootDir, markedOptions.highlight)
      else markedOptions.highlight

  (mimosaConfig, options, next) ->
    currentFile = options.files[0]
    marked currentFile.inputFileText.toString(), (err, htmlOuput) ->
      currentFile.outputFileText = htmlOuput
      currentFile.outputFileName = utilFile.swapFileNameExtension currentFile.outputFileName, 'html'
      next()

module.exports =
  registration: registration
  registerCommand: registerCommand
  defaults: config.defaults
  placeholder: config.placeholder
  validate: config.validate
