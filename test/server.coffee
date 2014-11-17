Server = require "../src/server/server"
server = new Server global.configuration

module.exports =

  describe "server", ->
    before "run", ->
      server.run()

    after "close", ->
      server.close()
