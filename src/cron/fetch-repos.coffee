assert = require "assert"
CronJob = require("cron").CronJob
cson = require "cson"
languages_file = cson.parseFileSync "./files/languages.cson"
CronHelper = require "./helper"
cron_helper = new CronHelper
# FIXME: need logger
#logger = require "../util/logger"


# rate limit is 20 per minute, doing 12 to be safe
seconds_per_request = 5
assert.ok(seconds_per_request >= 3, "github search API rate limited to 20 per second")

# calculate how many minutes to run cron
num_languages = languages_file.languages.length
languages_flattened = []
languages_flattened = cron_helper.flatten_languages_obj languages_file

console.log languages_flattened
#console.log Object.keys(languages_file.languages).length
minutes_required = Math.ceil(num_languages/seconds_per_request)

# convert two-layered languages object to array for manual cursor iteration
current_language_index = 0
max_language_index = languages_flattened.length
last_cron_time = null

# cron job running once a week at minimally-required time to fetch all languages
#fetch_repos_job = new CronJob "*/3 00-#{minutes_required} 03 * * 02", ->
fetch_repos_job = new CronJob "* * * * * *", ->
  console.log "cron job firing"
  # if starting a new cron cycle, record current time
  if current_language_index == 0
    last_cron_time = new Date().getTime()
  # begin/continue processing languages until you hit end
  if current_language_index > max_language_index
    #logger.log "cron job firing: attempting to fetch and store repos"
    cron_helper.fetch_and_store_repos language
    current_language_index++
  # once you hit end of languages, use a wait-limit to stop fetching
  if current_language_index <= max_language_index
    difference_in_hours = cron_helper.get_difference_in_hours(last_cron_time, new Date().getTime())
    # wait-limit is set to 72 hours, but could be anything above ~1 minute
    if difference_in_hours > 72
      current_language_index = 0
, null, true, "America/Los_Angeles"
