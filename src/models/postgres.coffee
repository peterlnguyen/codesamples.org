postgres = require "pg"
cson = require "cson"
config = cson.parseFiler("../../env/#{process.custom_env}/#{process.current_env}")
{address, port, username, password} = config.db.postgres
con_string = "postgres://#{username}:#{password}@#{address}:#{port}/#{database}"

class Postgres =

  constructor: ->
    postgres.connect con_string, (err, client, done) ->
      # do something
      
  # should parsing be done here?  should caller just pass in simplistically-formatted data?
  store: (results, callback) ->
    # parse, interpolate variables into sql statement

# singleton because only connect once
pg = new Postgres
module.exports = pg
