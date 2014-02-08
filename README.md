Mimosa Markdown
===========
## Overview

This mimosa module allows you to use markdown documents, which will be compiled to html static files.
For more information regarding Mimosa, see http://mimosa.io

### Warning

This module has been implemented and slightly tested during its development with mimosa 2.0.0-rc9 on Linux.

## Usage

Add `markdown` to your list of modules.  That's all!  Mimosa will install the module for you when you start up.

## Functionality

The module pick the markdown files in the compiled directory (`sourceDir` property from `watch` Mimosa configuration section) which have the specified extensions from the `extensions` option configuration of this module and compile to static html files under the compiled directory (`compiledDir` property from `watch` Mimosa configuration section).

## Configuration
### Default

The default configuration added to your mimosa configuration file when them module is installed is:

```javascript
markdown: {
  extensions: ['md'],
  options: { }
}
```

### Properties

The only configuraiton properties which pertain itself module is `extensions`, which is an array with the file extensions that will be considered as markdown documents, so they will be compiled to static html files. Bear in mind that the extensons are just the letters of the extension, it means the dot musn't be typed.
The other one configuration paramter is `options` which is an object which contains the configurations accepted by [marked node module](https://github.com/chjj/marked), but just providing a syntax sugar on two of them:

* `renderer`: This option parameter can be one of the next types:
  * Function: it will be considered that is a constructor, so the constructor must instantiate a valid `marked` renderer object
  * String: the name of a node module which must export a constructor function under 'Renderer' name. The module will be required as usual, so it can be a dependency module or just a script path which must be relative to the project's root folder
  * Object: a valid `marked` renderer instance

* `highlight`: this options parameter can be one of the next types:
  * Function: the function which performs the syntax highlighting as `marked` requires
  * String: the name of a node module which must export the function which performs the syntax highlighting as `marked` requires; it can be a dependency module or just a script path which must relative to the project's root folder

Any syntax sugar provided doesn't modify anything at all over `marked` options, which the are processed in mimosa and provided to `marked` as it originally requires.

### Example

Here there are some examples for the better understanding of the provided tiny syntax sugar options paramters:

* Using a node module script under the project's root directory

```javascript
markdown: {
  options: {
    renderer: './src/my-renderer'
  }
}
```

* Using a node module in the dependencies managed by require

```javascript
markdown: {
  options: {
    renderer: 'non-existing-marked-renderer'
  }
}
```

Note that `non-exiting-marked-renderer` should export a constructor under `Renderer` property (e.g. `module.exports.Renderer = function ....`)

* Using a `Renderer` instance referenced in the same configuration file

```javascript
var Renderer  = require('non-existing-marked-renderer);
var myRenderer = new Renderer();

....

  markdown: {
   options: {
     renderer: myRenderer
   }
  }
...
```

* Using a valid highlight `marked` function embedded in the same configuration file

```javascript
function highlightener(code, lang, callback) {
    require('pygmentize-bundled')({ lang: lang, format: 'html' }, code, function (err, result) {
          callback(err, result.toString());
    });
}

....

  markdown: {
    options: {
      highlight: highlightener
   }
  }
....
```

## Under hood

This module doesn't perform any smart operations, just integrate into the mimosa web framework workflow the markdown documents compilation using using [marked node module](https://github.com/chjj/marked).

## License

The MIT License

Copyright (c) 2014 Ivan Fraixedes Cugat <ifcdev@gmail.com>
