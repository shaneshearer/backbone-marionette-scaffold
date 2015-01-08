module.exports = (grunt, vars, utils) ->
  return {
    compile:
      options:
        namespace: "Application.Templates"
        processName: (filePath) ->
          filePath.replace(/^templates\//, '').replace(/\.hbs$/, '')
      files:
        "public/templates.js": ["templates/**/*.hbs"]
  }