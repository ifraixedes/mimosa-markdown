'use strict'

exports.defaults = ->
  markdown:
    extensions: ['md']

exports.placeholder = ->
  """
  \t
    # markdown:   
      # extensions: ['md']                      # The list of file extensions which will be considered as 
                                                # markdown files, therefore they will be compiled                                         
  """

exports.validate = (config, validators) ->
  errors = []
  if validators.ifExistsIsObject(errors, 'markdown config', config.markdown)
    if validators.ifExistsIsArray(errors, 'markdown.extensions', config.markdown.extensions)
      for extension in config.markdown.extensions
        unless typeof extension is 'string'
          errors.push 'markdown.extensions must be an array of strings'
          break

  errors


