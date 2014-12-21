postgres = require "pg"
cson = require "cson"
#config = cson.parseFileSync("./env/#{process.custom_env}/#{process.custom_env}.cson")
# FIXME: need to pass in env variables
config = cson.parseFileSync("./env/development/development.cson")
{address, port, username, password, database} = config.database.postgres
con_string = "postgres://#{username}:#{password}@#{address}:#{port}/#{database}"


class Postgres

  constructor: ->
    postgres.connect con_string, (err, client, done) ->
      # do something
      
  # should parsing be done here?  should caller just pass in simplistically-formatted data?
  store: (results, callback) ->
    # parse, interpolate variables into sql statement

# singleton because only connect once
pg = new Postgres
module.exports = pg
