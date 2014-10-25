GithubApi = require "github"

module.exports = class Github

  constructor: ->
    @github = new GithubApi
      version: "3.0.0",
      debug: true,
      protocol: "https",

  # search for trending repos
  @search_repos: (query, callback) ->
    msg =
      q: query
      sort: "desc"
      page: 5
    @github.repos msg, callback
