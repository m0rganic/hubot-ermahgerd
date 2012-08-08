Tests  = require('./tests')
assert = require 'assert'
helper = Tests.helper()

Robot         = require '../src/robot'
{TextMessage} = require '../src/message'

require('../src/scripts/ermahgerd') helper

console.log '9'
# start up a danger room for hubt speak
danger = Tests.danger helper, (req, res, url) ->
  res.writeHead 200
  res.end JSON.stringify(
    responseData:
      results: [
        unescapedUrl: "(#{url.query.q})"
      ]
  )

# callbacks for when hubot sends messages
tests = [
  (msg) -> assert.equal "ERSUM", msg
  (msg) -> assert.equal "STERT TERPIN", msg
]

msgs = [
  'helper: ermahgerd awesome',
  'helper: ermahgerd start typing'
] 

# run the async tests
user = {}
danger.start tests, ->
  for m in msgs
    helper.receive new TextMessage user, m

  helper.stop()
