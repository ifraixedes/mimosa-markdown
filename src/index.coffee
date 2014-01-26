'use strict'

config = require  './config'

registration = (mimosaConfig, register) ->
  register ['add', 'update', 'buildFile'], 'compile', _markdownCompiler(mimosaConfig.markdown), mimosaConfig.markdown.extensions

registerCommand = (program, retrieveConfig) ->

_markdownCompiler = (markdownConfig) ->
  marked = require 'marked'
  utilFile = require './util/file'

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

