module.exports = (grunt, vars, utils) ->
  return {
    html:
      files: [
        "src/**/*.html"
      ]
      tasks: [
        "copy:html"
      ]
      options:
        spawn: false

    coffeescript:
      files: [
        "src/js/**/*.coffee"
        "!src/**/.#*.coffee"
        "!src/vendor/**/*.coffee"
        "test/**/*.coffee"
        "!test/**/.#*.coffee"
        "!test/lib/**/*.coffee"
        "!**/*flymake.coffee"
        "!node_modules/**/*.coffee"
        "!node_modules/**/*.js"
        "!.**/*"
      ]
      tasks: [
        "coffeelint:app"
        "coffee:changed"
      ]
      options:
        spawn: false

    handlebars:
      files: [
        "templates/**/*.hbs"
      ]
      tasks: [
        "handlebars:compile"
      ]
      options:
        spawn: false

    sass:
      files: [
        "src/**/*.scss"
      ],
      tasks: [
        "sass:development"
      ]
      options:
        spawn: false

    configuration:
      files: [
        "configuration/**/*.json"
      ],
      tasks: [
        "copy:configuration"
      ]
      options:
        spawn: false

    copy:
      files: [
        "src/config/manifest.json"
        "!.**/*"
      ]
      tasks: [
        "copy:config"      
      ]
      options:
        spawn: false

    livereload:
      options:
        livereload: true
        dot: false
      files: [
        "public/*"
        "public/**/*"
        "!public/**/.#*"
        "!public/vendor/**/*"
        "!public/test/lib/**/*"
        "!.**/*"
      ]
  }
