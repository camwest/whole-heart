app = require __dirname + '/../config/application'

VIEW_PATH = "#{__dirname}/views"

# view files must export a 'sync' method which
# syncs their data up to the couch db server
exports.sync = (filename) ->
  modulePath = exports.pathTo(filename)
  delete(require.cache[require.resolve(modulePath)])
  view = require modulePath
  view.sync(app)

# returns a full working path to the file
exports.pathTo = (filename) ->
  "#{VIEW_PATH}/#{filename}"
