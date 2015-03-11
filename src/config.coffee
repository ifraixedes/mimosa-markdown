'use strict'

exports.defaults = ->
  markdown:
    extensions: ['md']
    options: { }

exports.validate = (config, validators) ->
  errors = []
  if validators.ifExistsIsObject(errors, 'markdown config', config.markdown)
    if validators.ifExistsIsArray(errors, 'markdown.extensions', config.markdown.extensions)
      for extension in config.markdown.extensions
        unless typeof extension is 'string'
          errors.push 'markdown.extensions must be an array of strings'
          break
    if validators.ifExistsIsObject(errors, 'markdown.options', config.markdown.options)
      if config.markdown.options.renderer?
        rendererOptionType = typeof config.markdown.options.renderer
        if rendererOptionType isnt 'string' and rendererOptionType isnt 'object' and rendererOptionType isnt 'function'
          errors.push 'markdown.options.renderer must be a string or an object or a function'
      if config.markdown.options.highlight?
        rendererOptionType = typeof config.markdown.options.highlight
        if rendererOptionType isnt 'string' and rendererOptionType isnt 'function'
          errors.push 'markdown.options.highlight must be a string or a function'

  errors
