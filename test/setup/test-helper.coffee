cson = require "cson"


global.configuration = cson.parseFileSync "./env/test/test.cson"
