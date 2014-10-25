Server = require "../src/server/server"


describe "server", ->
  before ->
    cson.parseFile "./env/test/test.cson", (err, configuration) ->
      if err
        console.error "Error opening test configuration #{name}: #{err}"
        process.exit(-1)
      else
        Server.run configuration

  after ->
    Server.close()
