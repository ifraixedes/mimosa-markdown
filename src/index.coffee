'use strict'

config = require  './config'

registration = (mimosaConfig, register) ->
  register ['add', 'update', 'buildFile'], 'compile', _markdownCompiler(mimosaConfig.markdown), mimosaConfig.markdown.extensions

registerCommand = (program, retrieveConfig) ->

_markdownCompiler = (markdownConfig) ->
  marked = require 'marked'
  utilFile = require './util/file'
  markedOptions = utilFile.clonePlainObject markdownConfig.options

  if markedOptions.renderer
    markedOptions.renderer = switch typeof markedOptions.renderer
      when 'function' then new markedOptions.renderer
      when 'string' then new (require markedOptions.renderer).Renderer
      else markedOptions.renderer

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
