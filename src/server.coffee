express = require "express"
router = express.Router()
cson = require "cson-safe"


module.exports = class Server

  @run: (configuration) ->
    (new @ configuration).run()

  constructor: (@configuration) ->

    {@server, @db} = @configuration

    @app = express()

  run: ->
    server = @app.listen(@server.port)
    server.on "listening", =>
      {address, port} = server.address()
      console.log "Web server running on #{address}:#{port}"


router.get "/:text", (req, res) ->
  console.log cson.parse.toString()
  res.send "ok!"
