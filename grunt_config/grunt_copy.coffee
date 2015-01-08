module.exports = (grunt, vars, utils) ->
  return {
    vendor:
      files: [{
        expand: true
        src: ["vendor/**"]
        dest: "public/"
      }]

    configuration:
      files: [{
        expand: true
        src: ["configuration/**"]
        dest: "public/"
      }]

    html:
      files: [{
        expand: true
        flatten: true
        cwd: 'src/'
        src: [
          '*.html'
          '**/*.html'
        ]
        dest: 'public/'
      }]

    img:
      files: [{
        expand: true
        cwd: "src"
        src: ["img/**"]
        dest: "public/"
      }]

    config:
      files: [{
        expand: true
        flatten: true
        src: vars.manifestPath
        dest: "public/config/"
        rename: (dest, src) ->
          "#{dest}manifest.json"
      }]

    test:
      files: [{
        expand: true
        flatten: false
        src: ["test/lib/**"]
        dest: "public/"
      }]
  }
