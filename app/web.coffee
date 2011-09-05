express = require('express')
Rsvp = require('./models/rsvp').Rsvp
titleizer = require('./helpers/titleizer')
cradle = require('cradle')

app = express.createServer express.logger()

app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session( secret: "here is a random secret that no one will guess" )

app.dynamicHelpers( messages: require('express-messages') );

port = process.env.PORT || 3000;

app.listen port, ->
  console.log "Listening on #{port}"

app.configure ->
  console.log "Setting up configuration"
  app.use express.compiler { src: "#{__dirname}/../public", enable: ['less'] }
  app.use express.static "#{__dirname}/../public"
  app.set "envConfig", "#{__dirname}/../config/environments"

["development", "test", "production"].forEach (env) ->
  app.configure env, ->
    require( app.set('envConfig') + '/' + env ).load(app);

app.get '/', (req, res) ->
  res.render 'index.ejs'

app.get '/admin/rsvp', (req, res) ->
  db = new(cradle.Connection)().database app.set 'couchdb'
  db.view 'rsvp/all', (error, response) ->
    res.render 'rsvp/index.ejs', rsvps: response

app.get '/rsvp/thank_you', (req, res) ->
  res.render 'rsvp/thank_you.ejs', layout: 'layouts/details', title: titleizer.title 'rsvp'

app.get '/rsvp/new', (req, res) ->
  res.render 'rsvp/new.ejs', layout: 'layouts/details', title: titleizer.title 'rsvp'

app.post '/rsvp', (req, res) ->
  rsvp = new Rsvp req.body.rsvp

  rsvp.save (errors, persisted) ->
    if persisted
      res.redirect '/rsvp/thank_you'
    else
      req.flash 'error', "Errors: #{errors.join(", ")}"
      res.render 'rsvp/new.ejs', layout: 'layouts/details', title: titleizer.title 'rsvp'

app.get '/:detail_page', (req, res) ->
  detail_page = req.params.detail_page
  res.render "details/#{detail_page}.ejs", layout: 'layouts/details', title: titleizer.title detail_page
