express = require "express"
router = express.Router()

router.use (req, res, next) ->
  console.log req.method, req.url
  next()

router.get "/", (req, res) ->
  res.send "hello world!"


module.exports = router
