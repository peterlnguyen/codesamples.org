assert = require "assert"
http = require "http"
#require "../server"
Server = require "../../src/server/server"
{address, port} = global.configuration.server


before "start server", ->
  Server.run {address, port}

after "close server", ->
  Server.close

describe "/", ->
  it "should return 200", (done) ->
    http.get "http://#{address}:#{port}", (res) ->
      assert.equal 200, res.statusCode
      done()
