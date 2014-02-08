'use strict'
{extname} = require 'path'

swapFileNameExtension = (pathFileName, newExtension) ->
  "#{pathFileName.substr(0, pathFileName.indexOf extname(pathFileName))}.#{newExtension}"

clonePlainObject = (srcObj) ->
  JSON.parse JSON.stringify(srcObj)
  
module.exports =
  swapFileNameExtension: swapFileNameExtension
  clonePlainObject: clonePlainObject
