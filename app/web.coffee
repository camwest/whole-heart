express = require('express')
app = express.createServer express.logger()

app.get 'details', (req, res) ->
  res.render 'details.ejs'

app.get '/', (req, res) ->
  res.render 'index.ejs'

app.get '/rsvp/new', (req, res) ->
  res.render 'rsvp/new.ejs'

app.post '/rsvp', (req, res) ->
  console.log req.body

  res.send "HELLO WORLD"

  rsvp = Rsvp.new req.params.rsvp

  if rsvp.save()
    # save
  else
    res.render 'rsvp/new.ejs', { errors: rsvp.errors }

port = process.env.PORT || 3000;

app.listen port, ->
  console.log "Listening on #{port}"

app.configure "development", ->
  app.use express.compiler { src: "#{__dirname}/../public", enable: ['less'] }
  app.use(express.static("#{__dirname}/../public"))
  app.use express.bodyParser()
