module.exports = (grunt, vars, utils) ->
  return {
    options:
      banner: "/*! <%= pkg.name %> <%= grunt.template.today('yyyy-mm-dd') %> */\n"

    production:
      files: [{
        "public/dataGrid.min.js": ["public/dataGrid.js"]
      }]
  }
