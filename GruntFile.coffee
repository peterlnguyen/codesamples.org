module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-coffeelint"

  grunt.initConfig
    coffeelint:
      app: [
        "src/*.coffee",
        "public/*.coffee"
      ],
      tests: [
        "tests/*/*.coffee"
      ]

  grunt.registerTask "default", "coffeelint"
  grunt.registerTask "travis", "lint"
