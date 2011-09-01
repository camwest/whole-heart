cradle = require('cradle')
cradle.setup host: process.env.CLOUDANT_URL

module.exports.load = (app) ->
  app.set 'couchdb', 'whole-heart_production'
