cradle = require 'cradle'

module.exports.sync = (app) ->
  db = new(cradle.Connection)().database app.set 'couchdb'
  db.save '_design/rsvp',
    accepts:
      map: (doc) ->
        if doc.type == 'rsvp' && doc.attending == 'accepts'
          emit doc._id, doc
    all:
      map: (doc) ->
        if doc.type == 'rsvp'
          emit doc._id, doc
