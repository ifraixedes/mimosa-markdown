'use strict'
{extname} = require 'path'

swapFileNameExtension = (pathFileName, newExtension) ->
  "#{pathFileName.substr(0, pathFileName.indexOf extname(pathFileName))}.#{newExtension}"
  
module.exports =
  swapFileNameExtension: swapFileNameExtension
