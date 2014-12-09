assert = require "assert"
CronJob = require("cron").CronJob
cson = require "cson"
languages = cson.parseFile "../../files/languages"
Github = require "../models/github"
github = new Github


# rate limit is 20 per minute, doing 12 to be safe
seconds_per_request = 5
assert.true(seconds_per_request >= 3, "github search API rate limited to 20 per second")

# calculate how many minutes to run cron
num_languages = languages.languages.length
minutes_required = Math.ceil(num_languages/seconds_per_request)

# convert two-layered languages object to array for manual cursor iteration
languages_array = object_to_array languages
current_language_index = 0
max_language_index = languages_array.length

# cron job running once a week at minimally-required time to fetch all languages
fetch_repos_job = new CronJob "00-19 00-#{minutes_required} 03 * * 02", ->
  # need to iterate through languages and feed into fetch_repos_request
  # TODO: memoize day; if current_day is DIFFERENT, reset current_language_index
  # temporarily keep track of fetched_languages in redis instead?
  if current_language_index > max_language_index
    fetch_repos_request language
, null, true, "America/Los_Angeles"

fetch_repos_request = (language) ->
  search_query = "language: #{language}"
  github.search_repos search_query, (err, res) ->
    # store to postgres
#    parsed_data = parse_results res
#    pg_model.store res, (err, res) ->
#      console.log "something bad happened"
#    console.log err, res

object_to_array = (languages) ->
  flattened_languages = []
  for letter_category in languages
    for language in letter_category
      flattened_languages.push language
  flattened_languages
