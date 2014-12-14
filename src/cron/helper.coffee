# postgres is a singleton
postgres = require "../models/postgres"
Github = require "../models/github"
github = new Github

module.exports = class CronHelper =

  get_difference_in_hours: (time_behind, time_ahead) ->
      difference = time_ahead - time_behind
      difference_in_hours = (difference/(1000*60*60))%24
      return difference_in_hours

  fetch_repos_request: (language) ->
    search_query = "language: #{language}"
    github.search_repos search_query, (err, res) ->
      # store to postgres
  #    parsed_data = parse_results res
  #    console.log err, res

  store_repos: (results, callback) ->
      postgres.store res, callback

  object_to_array: (languages) ->
    flattened_languages = []
    for letter_category in languages
      for language in letter_category
        flattened_languages.push language
    flattened_languages
