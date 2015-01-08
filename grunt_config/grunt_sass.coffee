module.exports = (grunt, vars, utils) ->
  return {
    development:
      options:
        style: "expanded"
        debugInfo: true
        lineNumbers: true
        require: []
      expand: true
      cwd: "./src/css/"
      src: [
        "*.scss"
        "**/*.scss"
        "!.#*.scss"
        "!**/.#*.scss"
        ]
      dest: "./public/css/"
      ext: ".css"

    production:
      options:
        style: "compressed"
        require: []
      expand: true
      cwd: "./src/css/"
      src: [
        "*.scss"
        "**/*.scss"
        "!.#*.scss"
        "!**/.#*.scss"
        ]
      dest: "./public/css/"
      ext: ".css"
  }