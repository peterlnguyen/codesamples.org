GithubApi = require "github"

module.exports = class Github

  constructor: ->
    @github = new GithubApi
      version: "3.0.0"
      debug: true
      protocol: "https"
      #pathPrefix: "/api/v3"

  # search for trending repos based on stars
  search_repos: (query, callback) ->
    msg =
      q: query
      sort: "stars"
      order: "desc"
      page: 5
    @github.search.repos msg, callback
