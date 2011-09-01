cradle = require('cradle')
app = require( __dirname + '/../../config/application' )
db = new(cradle.Connection)().database app.set 'couchdb'

console.log app.set 'couchdb'

class Rsvp
  # build an rsvp object based on the parameters
  constructor:(params = {}) ->
    @name = params.name
    @attending = params.attending
    @how_i_know_them = params.how_i_know_them

  save: (callback) ->
    if (@valid())
      @create ->
        callback(@errors, true)
    else
      callback(@errors, false)

  valid: ->
    errors = []

    errors.push @check "name"
    errors.push @check "attending"

    @errors = @removeUndefined(errors)

    if @errors.length == 0 then true else false

  check: (field) ->
    if @[field] == undefined || @[field] == ""
      return "#{field} is required"

  removeUndefined: (errors) ->
    errors.filter (error) ->
      error != undefined

  # save the record to couchdb
  create: (callback) ->
    document = 
      type: 'rsvp',
      created_at: new Date
      name: @name
      attending: @attending
      how_i_know_them: @how_i_know_them

    db.save document, (error, response) ->
      callback()

module.exports.Rsvp = Rsvp

