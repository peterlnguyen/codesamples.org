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

      test:
        options:
          reporter: "spec"
          require: "coffee-script/register"
        src: [
          "test/**/*.coffee"
        ]

      "test-functional":
        options:
          reporter: "spec"
          require: "coffee-script/register"
        src: [
          "test/functional/**/*.coffee"
        ]

      "test-unit":
        options:
          reporter: "spec"
          require: "coffee-script/register"
        src: [
          "test/unit/**/*.coffee"
        ]


  grunt.registerTask "default", "coffeelint"
  grunt.registerTask "test", "mochaTest:test"
  grunt.registerTask "test-functional", "mochaTest:test-functional"
  grunt.registerTask "test-unit", "mochaTest:test-unit"
