default_options = (src) ->
  options:
    reporter: "spec"
    require: "coffee-script/register"
  src: src

module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    coffeelint:
      app: [
        "src/*.coffee",
        "public/*.coffee"
      ],
      tests: [
        "tests/*/*.coffee"
      ]

    mochaTest:
      test: default_options ["test/**/*.coffee"]
      "test-functional": default_options ["test/functional/**/*.coffee"]
      "test-unit": default_options ["test/unit/**/*.coffee"]


  grunt.registerTask "default", "coffeelint"
  grunt.registerTask "test", "mochaTest:test"
  grunt.registerTask "test-functional", "mochaTest:test-functional"
  grunt.registerTask "test-unit", "mochaTest:test-unit"
