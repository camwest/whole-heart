express = require('express')
Rsvp = require('./models/rsvp').Rsvp

app = express.createServer express.logger()

app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session({ secret: "here is a random secret that no one will guess" })

app.dynamicHelpers({ messages: require('express-messages') });

app.get 'details', (req, res) ->
  res.render 'details.ejs'

app.get '/', (req, res) ->
  res.render 'index.ejs'

app.post '/', (req, res) ->
  res.send req.body

app.get '/rsvp/thank_you', (req, res) ->
  res.render 'rsvp/thank_you.ejs'

app.get '/rsvp/new', (req, res) ->
  res.render 'rsvp/new.ejs'

  app.post '/rsvp', (req, res) ->
    rsvp = new Rsvp req.body.rsvp

    rsvp.save (errors, persisted) ->
      if persisted
        res.redirect '/rsvp/thank_you'
      else
        req.flash 'error', "Errors: #{errors.join(", ")}"
        res.render 'rsvp/new.ejs'

port = process.env.PORT || 3000;

app.listen port, ->
  console.log "Listening on #{port}"

app.configure ->
  console.log "Setting up configuration"
  app.use express.compiler { src: "#{__dirname}/../public", enable: ['less'] }
  app.use express.static "#{__dirname}/../public"
