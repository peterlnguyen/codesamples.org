express = require "express"
router = express.Router()
routers = require "../routers/main"
cson = require "cson-safe"


module.exports = class Server

  @run: (configuration) ->
    (new @ configuration).run()

  @close: ->
    @app?.close()

  load_routers: (routers, app) ->
    for key, value of routers
      app.use value

  constructor: (@configuration) ->
    {@server, @db} = @configuration
    @app = express()
    @load_routers routers, @app

  run: ->
    server = @app.listen(@server.port)
    server.on "listening", =>
      {address, port} = server.address()
      console.log "Web server running on #{address}:#{port}"
