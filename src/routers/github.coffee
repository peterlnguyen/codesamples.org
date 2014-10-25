express = require "express"
router = express.Router()

router.use (req, res, next) ->
  console.log req.method, req.url
  next()

router.get "/github/trending/:language", (req, res) ->
  res.send "hello world!"

router.get "/github", (req, res) ->
  res.send "hello world!"


module.exports = router

  

