module.exports = (grunt) ->

  # Determine what 'mode' the requested task is running under
  buildMode = (->
    taskMap =
      "default"    : "development"
      "production" : "production"
    taskMap[ grunt.cli.tasks[0] ] or "development"
  )()

  ##############################################################
  ##
  ## Properties
  ## ---------------------------------------------------------
  ## Commonly used build settings are kept within the 'vars'
  ## object and are made available to all external grunt
  ## tasks in the 'config/' folder upon execution.
  ##
  ##############################################################

  vars =

    # Node OS Module
    os: require "os"

    # Application Output/build Directory
    buildDir: "public/"

    # Grunt's Configuration Directory
    configDir: "config/"

    manifestDevelopmentPath: "src/config/manifest_development.json"

    # Path to application's dependency manifest JSON file
    manifestPath: (->
      grunt.log.writeln "Reading '#{buildMode}' Manifest File"
      "src/config/manifest_#{buildMode}.json"
    )()

    # Copy dynamic buildMode for use in tasks
    buildMode: buildMode

    # Directory containing application code
    sourceDir: "src/"

    # Directory containing automated tests
    testDir: "test/"


  ##############################################################
  ##
  ## Utility Methods
  ## --------------------------------------------------------
  ## Commonly used build functions are kept within the 'utils'
  ## object and are made available to all external grunt
  ## tasks in the 'config/' folder upon execution.
  ##
  ##############################################################

  utils =

    # Dynamically configure a :changed grunt task to process an
    # individual file. Add the file type to the grunt_watch.coffee
    # configuration and register a task with a subtask of ':changed'.
    #
    # This is run before the actual task list is executed so this
    # allows us to inject this dynamic command for an individually
    # changed file.
    configureGruntChangedTask: (target, filepath, ext, dest = "public/", cwd = "src/", options = {}) ->
      filepath = filepath.replace cwd, ""

      grunt.config target,
        changed:
          expand: true
          cwd: cwd
          src: filepath
          dest: dest
          ext: ".#{ext}"
          options: options

    getBuildNumber: (environment) ->
      build_number = process.env.BUILD_NUMBER || vars.os.hostname()
      "#{environment}-#{build_number}"

    # Provide access to the requested task using dot syntax to
    # traverse object hierarchy
    getGruntConfig: (path) ->
      grunt.config(path)

    # Generate Haml for a given type of dependency in the manifest file
    getTemplateTaskHamlFor: (dependency, path = "../") ->
      dependencies = @loadManifestDependenciesFor(dependency, path).map (dep) ->
        d = new Date()
        dateString = "#{d.getFullYear()}#{d.getMonth()}#{d.getDate()}#{d.getHours()}#{d.getMinutes()}#{d.getSeconds()}"
        if dependency is "javascript"
          "%script{ src: \"#{dep}?#{dateString}\" }"
        else if dependency is "css"
          "%link{ rel: \"stylesheet\", href: \"#{dep}?#{dateString}\" }"
      dependencies.join "\n    "

    # Retrieve the data under the specified dependency type of the manifest file
    loadManifestDependenciesFor: (type, dirPrefix = "public/", useDevelopment = false) ->
      json = grunt.file.readJSON (if useDevelopment then vars.manifestDevelopmentPath else vars.manifestPath)
      json.dependencies[type].map (path) -> "#{dirPrefix}#{path}"

    # Retrieve the external coffeescript configuration for the supplied task.
    # only files following the established convention will work...
    #
    #   Example:
    #     config/grunt_${TASK_NAME}.coffee
    #
    # Tasks with hyphons should be replaced with underscores
    loadExternalConfig: (filename) ->
      filepath = "./grunt_config/grunt_#{filename}.coffee"
      grunt.log.writeln "[loadExternalConfig: #{filename}]"
      require(filepath)(grunt, vars, utils)


  ##############################################################
  ##
  ## General Configuration
  ## ---------------------------------------------------------
  ## Loading of external grunt task configuration files. All
  ## external files are written in CoffeeScript and can be
  ## found in the 'config/' directory prefixed with 'grunt_'.
  ##
  ##   Example for the 'coffee' task:
  ##     Create file named 'config/grunt_coffee.coffee'
  ##
  ##   Example for the 'regex-replace' task:
  ##     Create file named 'config/grunt_regex_replace.coffee'
  ##
  ## All external configuration files are provided access to
  ## commonly used build settings and functions by way of
  ## the module pattern.
  ##
  ##   Example boilerplate configuration
  ##     module.exports = (grunt, vars, utils) ->
  ##       return {
  ##         # Your configuration code goes here
  ##       }
  ##
  ##############################################################

  config = { pkg: grunt.file.readJSON "bower.json" }

  # Add the name of your task to this alphabetically sorted array so it is loaded
  [ "coffee", "coffeelint", "clean", "connect", "copy", "handlebars", "sass", "uglify", "watch" ].forEach (t) ->
      config[t] = utils.loadExternalConfig t.replace("-", "_")

  grunt.initConfig config


  ##############################################################
  ##
  ## Events
  ##
  ##############################################################

  # Attach to the 'watch' event so we can intelligently process
  # the file that was changed and so avoiding re-processing the
  # entire source tree
  grunt.event.on "watch", (action, filepath, target) ->
    isTest = filepath.match /^test\//
    cwd = if isTest then vars.testDir else vars.sourceDir
    dest = if isTest then "#{vars.buildDir}#{vars.testDir}" else vars.buildDir
    grunt.log.writeln "Target: #{target}"
    grunt.log.writeln "File: #{filepath}"

    switch target
      when "coffeescript"
        grunt.config "coffeelint.app", filepath
        utils.configureGruntChangedTask "coffee", filepath, "js", dest, cwd


  ##############################################################
  ##
  ## Dependencies
  ##
  ##############################################################

  grunt.loadNpmTasks task for task in [
    "grunt-coffeelint"
    "grunt-contrib-clean"
    "grunt-contrib-coffee"
    "grunt-contrib-connect"
    "grunt-contrib-copy"
    "grunt-contrib-handlebars"
    "grunt-contrib-uglify"
    "grunt-contrib-watch"
    "grunt-sass"
  ]


  ##############################################################
  ##
  ## Tasks
  ##
  ##############################################################

  developmentTasks = [
    "coffeelint"
    "clean:prebuild"
    "copy:config"
    "copy:vendor"
    "copy:configuration"
    "copy:html"
    "copy:img"
    "coffee:app"
    "handlebars:compile"
    "sass:development"
    "connect"
    "watch"
  ]

  productionTasks = [
    "coffeelint"
    "clean:prebuild"
    "copy:config"
    "copy:vendor"
    "copy:configuration"
    "copy:html"
    "copy:img"
    "coffee:app"
    "handlebars:compile"
    "sass:production"
  ]

  grunt.registerTask "default", developmentTasks
  grunt.registerTask "production", productionTasks
