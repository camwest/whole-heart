process.env.NODE_ENV = "test"
testCase = require('nodeunit').testCase
Rsvp = require('../app/models/rsvp').Rsvp
cradle = require('cradle')
db = new(cradle.Connection)().database('whole-heart_test')

couchClean = ->
  db.view 'rsvp/all', (error, response) ->
    for item in response
      db.remove item.id, item.value._rev

module.exports = testCase
  setUp: (ready) ->
    ready()

  tearDown: (clean) ->
    couchClean()
    clean()

  "save should return false when the rsvp is constructed without a name": (test) ->
    sut = new Rsvp
    sut.save (errors, persisted) ->
      test.ok !persisted
      test.ok (sut.errors.indexOf("name is required") != -1)
      test.done()

  "save should return false when the rsvp has a null name": (test) ->
    sut = new Rsvp name: ""
    sut.save (errors, persisted) ->
      test.ok !persisted
      test.ok (sut.errors.indexOf("name is required") != -1)
      test.done()

  "save should return false when the rsvp has no attending": (test) ->
    sut = new Rsvp name: "Name"
    sut.save (errors, persisted) ->
      test.ok !persisted
      test.ok (errors.indexOf("attending is required") != -1)
      test.done()

  "save should return true when the rsvp has attenting AND name": (test) ->
    sut = new Rsvp name: "Name", attending: false
    sut.save (errors, persisted) ->
      test.ok persisted
      test.done()

  "saving a record should create a new document": (test) ->
    original_count = 0

    db.view 'rsvp/all', (error, response) ->
      original_count = response.length

    sut = new Rsvp name: "Name", attending: false
    sut.save (errors, persisted) ->
      test.ok persisted

      db.view 'rsvp/all', (error, response) ->
        test.equal original_count + 1, response.length, "Should be one rsvp"
        #test.equal "Name", response[0].value.name
        #test.equal false, response[0].value.attending
        test.done()

