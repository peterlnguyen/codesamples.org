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
last_cron_time = null

# cron job running once a week at minimally-required time to fetch all languages
fetch_repos_job = new CronJob "*/3 00-#{minutes_required} 03 * * 02", ->
  # if starting a new cron cycle, record current time
  if current_language_index == 0
    last_cron_time = new Date().getTime()
  # continue processing languages until you hit end
  if current_language_index > max_language_index
    fetch_repos_request language
    current_language_index++
  # once you hit end of languages, use a wait-limit to stop fetching
  if current_language_index <= max_language_index
    difference = get_difference_in_hours(last_cron_time, new Date().getTime())
    # wait-limit is set to 72 hours, but could be anything above ~1 minute
    if difference_in_hours > 72
      current_language_index = 0
, null, true, "America/Los_Angeles"

get_difference_in_hours = (time_behind, time_ahead) ->
    difference = time_ahead - time_behind
    difference_in_hours = (difference/(1000*60*60))%24

fetch_repos_request = (language) ->
  search_query = "language: #{language}"
  github.search_repos search_query, (err, res) ->
    # store to postgres
#    parsed_data = parse_results res
#    console.log err, res

store_repos = (results, callback) ->
#    pg_model.store res, (callback) ->
#      console.log "something bad happened"

object_to_array = (languages) ->
  flattened_languages = []
  for letter_category in languages
    for language in letter_category
      flattened_languages.push language
  flattened_languages
