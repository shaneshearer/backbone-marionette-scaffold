module.exports = (grunt, vars, utils) ->
  return {
    app:
      expand: true
      cwd: "src/js/"
      src: [
        "*.coffee"
        "**/*.coffee"
        "!.#*.coffee"
        "!**/.#*.coffee"
        ]
      dest: "public/js/"
      ext: ".js"

    test:
      expand: true
      cwd: "test/"
      src: [
        "*.coffee"
        "**/*.coffee"
        "!lib/**/*.coffee"
        "!.#*.coffee"
        "!**/.#*.coffee"
      ],
      dest: "public/test/"
      ext: ".js"
  }
