fs = require('fs')
app = require( __dirname + '/../config/application' )

VIEW_PATH = "#{__dirname}/views"

fs.readdir VIEW_PATH, (err, dir) ->
  dir.forEach (filename) ->
    sync filename
    # watch the file for changes and sync again if it does
    fs.watchFile pathTo(filename), (curr, prev) ->
      console.log "#{filename} updated, re-synching..."
      sync filename

# view files must export a 'sync' method which
# syncs their data up to the couch db server
sync = (filename) ->
  modulePath = pathTo(filename)
  delete(require.cache[require.resolve(modulePath)])
  view = require modulePath
  view.sync(app)

# returns a full working path to the file
pathTo = (filename) ->
  "#{VIEW_PATH}/#{filename}"
