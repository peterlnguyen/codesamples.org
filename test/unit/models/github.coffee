chai = require "chai"
assert = chai.assert

Github = require "../../../src/models/github"


describe "unit tests for github api model", ->

  describe "function search_repo", ->
    it "should return the search results", (done) ->
      github = new Github
      #console.log github

      search_query = "tetris language:assembly"
      github.search_repos search_query, (err, res) ->
        assert.notOk err
        assert.ok res
        done()
