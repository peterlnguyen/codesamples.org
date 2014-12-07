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

fetch_repos_job = new CronJob "00-19 00-#{minutes_required} 03 * * 02", ->
  # need to iterate through languages and feed into fetch_repos_request
  fetch_repos_request language
, null, true, "America/Los_Angeles"

fetch_repos_request = (language) ->
  search_query = "language: #{language}"
  github.search_repos search_query, (err, res) ->
    # store to postgres
    console.log err, res
