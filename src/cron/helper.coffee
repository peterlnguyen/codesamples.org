Github = require "../models/github"


module.exports = class CronHelper

  constructor: ->
    @github = new Github
    # postgres is a singleton
    @postgres = require "../models/postgres"
    # logger may need to instantiate as class, assuming singleton for now
    #@logger = require "../util/logger"

  get_difference_in_hours: (time_behind, time_ahead) ->
      difference = time_ahead - time_behind
      difference_in_hours = (difference/(1000*60*60))%24
      return difference_in_hours

  fetch_and_store_repos: (language) ->
    search_query = "language: #{language}"
    @github.search_repos search_query, (gh_err, gh_res) ->
      if gh_res
        #@logger.error "github search repos error: #{gh_err}"
      else
        #@logger.log "github search repos success: #{gh_res}"
        @postgres.store results, (pg_err, pg_res) ->
        if pg_err
          #@logger.error "postgres store repos error: #{pg_err}"
        else
          #@logger.log "postgres store repos success: #{pg_res}"

  object_to_array: (languages) ->
    flattened_languages = []
    for letter_category in languages
      for language in letter_category
        flattened_languages.push language
    flattened_languages
