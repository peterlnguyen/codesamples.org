assert = require "assert"
http = require "http"
Server = require "../../src/server/server"
{address, port} = global.configuration.server


server = new Server global.configuration

before "start server", ->
  server.run()

after "close server", ->
  server.close()

describe "/", ->
  it "should return 200", (done) ->
    console.log "Test: Web server running on #{address}:#{port}"
    http.get "http://#{address}:#{port}", (res) ->
      assert.equal 200, res.statusCode
      done()
