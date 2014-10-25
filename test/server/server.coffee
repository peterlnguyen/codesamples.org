assert = require "assert"
http = require "http"


describe "/", ->
  it "should return 200", (done) ->
    http.get "http://localhost:8080", (res) ->
      assert.equal 200, res.statusCode
      done()
