fs = require 'fs'
views = require './view_sync'

VIEW_PATH = "#{__dirname}/views"

module.exports.sync = ->
  fs.readdir VIEW_PATH, (err, dir) ->
    dir.forEach (filename) ->
      views.sync filename
