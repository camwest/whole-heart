console.log "Configuring production environment..."

cradle = require('cradle')

dbUrl      = process.env.CLOUDANT_URL
dbAuth      = dbUrl.match(/https:\/\/(.*):(.*)@/)
dbUserName  = dbAuth[1]
dbPassword  = dbAuth[2]
dbHost      = "https://#{dbAuth[3]}"

cradle.setup 
  host: dbHost
  port: 443
  auth:
    username: dbUsername
    password: dbPassword

module.exports.load = (app) ->
  app.set 'couchdb', 'whole-heart_production'
