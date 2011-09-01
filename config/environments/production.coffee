console.log "Configuring production environment..."

cradle = require('cradle')

cradle.setup 
  host: "https://app728870.heroku.cloudant.com"
  port: 443
  auth:
    username: "app728870.heroku"
    password: "4LhClWxjOe8yjomJkFPCOkUq"

module.exports.load = (app) ->
  app.set 'couchdb', 'whole-heart_production'
