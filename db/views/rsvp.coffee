cradle = require 'cradle'

module.exports.sync = (app) ->
  db = new(cradle.Connection)().database app.set 'couchdb'
  db.save '_design/rsvp',
    all:
      map: (doc) ->
        if doc.type == 'rsvp'
          emit doc._id, doc
