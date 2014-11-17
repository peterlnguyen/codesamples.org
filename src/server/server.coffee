express = require "express"
router = express.Router()
routers = require "../routers/main"
cson = require "cson"


module.exports = class Server

  @run: (configuration) ->
    (new @ configuration).run()

  @close: ->
    @this_server?.close()

  load_routers: (routers, app) ->
    for key, value of routers
      app.use value

  constructor: (@configuration) ->
    {@server, @db} = @configuration
    @app = express()
    @load_routers routers, @app

  run: ->
    @this_server = @app.listen(@server.port)
    @this_server.on "listening", =>
      {address, port} = @this_server.address()
      console.log "Web server running on #{address}:#{port}"

  close: ->
    @this_server?.close()
