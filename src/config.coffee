'use strict'

exports.defaults = ->
  markdown:
    extensions: ['md']
    options: { }

exports.placeholder = ->
  """
  \t
    # markdown:   
      # extensions: ['md']                      # The list of file extensions which will be considered as 
                                                # markdown files, therefore they will be compiled 
      # options:                                # Object with the `marked` settings options.
                                                # Check https://github.com/chjj/marked to know what options
                                                # are available; this module by default doesn't modify the
                                                # default options that `marked` takes.
                                                # NOTE: The only options that differ from the original 
                                                # `marked` settings options are 
                                                # -`renderer`, which can be 
                                                #       - Function: it will be considered that is a constructor, 
                                                #         so the constructor must instantiate a valid `marked` 
                                                #         renderer object
                                                #       - String: the name of a node module which must export
                                                #         a constructor function under 'Renderer' name. The 
                                                #         module will be required as usual, so it can be
                                                #         a dependency module or just a script path which
                                                #         must relative to the project's root folder
                                                #       - Object: a valid `marked` renderer instance 
                                                # 
                                                #    e.g. You can populate this option parameter as "marked", 
                                                #         which will instance the `marked` default renderer,
                                                #         of course it will produce the same effect than
                                                #         not to populate this option parameter
                                                # - `highlight`, can be
                                                #       - Function: the function which performs the                                                 #       - String: the name of a node module which must export
                                                #         syntax highlighting as `marked` requires
                                                #       - String: the name of a node module which must export
                                                #         the function which performs the syntax highlighting
                                                #         as `marked` requires; it can be a dependency module 
                                                #         or just a script path which must relative to the
                                                #         project's root folder
                                                #
  """

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
