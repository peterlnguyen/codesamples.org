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
          "test/unit/**/*.js"
        ]


  grunt.registerTask "default", "coffeelint"
  grunt.registerTask "travis", "lint"
  grunt.registerTask "test", "mochaTest"
