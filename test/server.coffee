Server = require "../src/server/server"
{configuration: {server}} = global

module.exports =

  describe "server", ->
    before "run", ->
      Server.run server

    after "close", ->
      Server.close()
