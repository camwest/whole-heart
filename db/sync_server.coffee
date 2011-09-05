fs = require('fs')
views = require './view_sync'

VIEW_PATH = "#{__dirname}/views"

fs.readdir VIEW_PATH, (err, dir) ->
  dir.forEach (filename) ->
    views.sync filename
    # watch the file for changes and sync again if it does
    fs.watchFile views.pathTo(filename), (curr, prev) ->
      console.log "#{filename} updated, re-synching..."
      views.sync filename
